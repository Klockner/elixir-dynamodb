defmodule MetricsSpikeWeb.UpsertUserWebSessions do
  @session_minute_time_limit 30
  @session_day_time_limit 24

  def call(params) do
    %{"UserId" => user_id} = params
    {status, user_web_session} = MetricsDynamoDB.Query.call("PocUserWebSessions", "UserId", user_id, false)

    case status do
      :ok -> upsert_web_session(params, user_web_session)
      :error -> create_web_session(params, 0)
    end
  end

  def create_web_session(item = %{"UserId" => user_id, "CreatedAt" => created_at}, web_session_number) do
    updated_at_value = Map.get(item, "CreatedAt")
    new_item = Map.put(item, "UpdatedAt", updated_at_value) |> Map.put("WebSessionNumber", web_session_number + 1)

    MetricsDynamoDB.PutItem.call("PocUserWebSessions", new_item)
  end

  def upsert_web_session(params = %{"UserId" => _, "CreatedAt" => _}, user_web_session = %{UserId: _, CreatedAt: _, UpdatedAt: _, WebSessionNumber: web_session_number}) do
    event_created_at = Map.get(params, "CreatedAt")

    new_item = Map.put(user_web_session, :UpdatedAt, event_created_at)

    {:ok, event_date, _} = DateTime.from_iso8601(event_created_at)
    {:ok, web_session_date, _} = Map.get(user_web_session, :UpdatedAt) |> DateTime.from_iso8601
    {:ok, web_session_created_at_date, _} = Map.get(user_web_session, :CreatedAt) |> DateTime.from_iso8601

    case DateTime.diff(event_date, web_session_created_at_date, :second)/3600 > @session_day_time_limit do
      true -> create_web_session(params, web_session_number)
      false ->
        case DateTime.diff(event_date, web_session_date, :second)/60 > @session_minute_time_limit do
          true -> create_web_session(params, web_session_number)
          false -> MetricsDynamoDB.PutItem.call("PocUserWebSessions", new_item)
        end
    end
  end
end

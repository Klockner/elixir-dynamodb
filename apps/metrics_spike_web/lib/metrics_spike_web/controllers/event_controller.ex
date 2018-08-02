defmodule MetricsSpikeWeb.EventController do
  use MetricsSpikeWeb, :controller

  def index(conn, _params) do
    MetricsDynamoDB.CreateTable.call("Localiost", "name")
    text conn, 'oi'
  end

  def create(conn, params) do
    result = MetricsSpikeWeb.UpsertUserWebSessions.call(params)

    text conn, "query finished #{inspect(result)}"
  end

  def seed(conn, _params) do
    seed_async(2000)

    text conn, "seed finished"
  end

  def map_reduce_web_session(conn, _params) do
    count = MetricsSpikeWeb.MapReduceUserWebSessions.call("PocUserWebSessions", "CreatedAt")

    text conn, "counted #{count} web sessions"
  end

  defp create_seed(num) do
    event = %{UserId: Integer.to_string(num), CreatedAt: DateTime.utc_now |> DateTime.to_string}
    MetricsDynamoDB.PutItem.call("PocEvents", event)
  end

  defp seed_sync(n) do
    Enum.each(1..n, fn(num) ->
      create_seed(num)
    end)
  end

  defp seed_async(n) do
    Enum.each(1..n, fn(num) ->
      Task.async(fn ->
        create_seed(num)
      end)
    end)
  end
end

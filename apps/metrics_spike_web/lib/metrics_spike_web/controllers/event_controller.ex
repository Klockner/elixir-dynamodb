defmodule MetricsSpikeWeb.EventController do
  use MetricsSpikeWeb, :controller

  def index(conn, _params) do
    MetricsDynamoDB.CreateTable.call("Localiost", "name")
    text conn, 'oi'
  end

  def create(conn, params) do
    result = MetricsSpikeWeb.UpsertUserWebSessions.call(params)
    # result = MetricsDynamoDB.GetItem.call("PocEvents", "335")

    # %{"Items" => items} = result
    text conn, "query finished #{inspect(result)}"
  end

  def seed(conn, _params) do
    seed_async(2000)

    text conn, "seed finished"
  end

  def create_seed(num) do
    event = %{UserId: Integer.to_string(num), CreatedAt: DateTime.utc_now |> DateTime.to_string}
    MetricsDynamoDB.PutItem.call("PocEvents", event)
  end

  def seed_sync(n) do
    Enum.each(1..n, fn(num) ->
      create_seed(num)
    end)
  end

  def seed_async(n) do
    Enum.each(1..n, fn(num) ->
      Task.async(fn ->
        create_seed(num)
      end)
    end)
  end
end

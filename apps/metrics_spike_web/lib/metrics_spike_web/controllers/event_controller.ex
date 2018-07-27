defmodule MetricsSpikeWeb.EventController do
  use MetricsSpikeWeb, :controller
  import MetricsDynamoDB

  def index(conn, _params) do
    MetricsDynamoDB.CreateTable.call("Localiost", "name")
    text conn, 'oi'
  end
end

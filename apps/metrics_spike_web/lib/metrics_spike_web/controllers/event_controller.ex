defmodule MetricsSpikeWeb.EventController do
  use MetricsSpikeWeb, :controller

  def index(conn, _params) do
    text conn, 'oi'
  end
end

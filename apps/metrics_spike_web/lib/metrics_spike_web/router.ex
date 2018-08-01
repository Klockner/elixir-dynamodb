defmodule MetricsSpikeWeb.Router do
  use MetricsSpikeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MetricsSpikeWeb do
    pipe_through :api

    get "/", EventController, :index
    post "/", EventController, :create

    get "/seed", EventController, :seed
  end
end

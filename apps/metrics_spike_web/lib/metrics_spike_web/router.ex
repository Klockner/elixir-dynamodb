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
    get "/web_sessions", EventController, :map_reduce_web_session
  end
end

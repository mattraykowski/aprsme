defmodule AprsmeWeb.Router do
  use AprsmeWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", AprsmeWeb do
    pipe_through([:browser])

    get("/", PageController, :index)

    scope "/" do
      get("/map", MapController, :index)

      resources "/packets", PacketController, only: [:index, :show]
      resources "/call", CallController, only: [:show]

      get("/faq", PageController, :faq)
    end
  end
end

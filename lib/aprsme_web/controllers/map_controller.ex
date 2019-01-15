defmodule AprsmeWeb.MapController do
  use AprsmeWeb, :controller

  plug :put_layout, "map.html"

  def index(conn, _params) do
    render conn, "index.html"
  end
end

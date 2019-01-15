defmodule AprsmeWeb.PageController do
  use AprsmeWeb, :controller

  def index(conn, _params) do
    user = conn.assigns[:current_user]

    case user do
      nil ->
        render conn, "index.html"
      _ ->
        conn |> redirect(to: map_path(conn, :index))
    end
  end

  def faq(conn, _params) do
    render conn, "faq.html"
  end
end

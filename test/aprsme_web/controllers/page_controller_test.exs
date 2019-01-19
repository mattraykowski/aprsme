defmodule AprsmeWeb.PageControllerTest do
  use AprsmeWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "APRS.me"
  end
end

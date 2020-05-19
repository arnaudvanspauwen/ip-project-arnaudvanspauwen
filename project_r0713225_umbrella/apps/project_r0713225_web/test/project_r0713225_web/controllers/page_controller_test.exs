defmodule ProjectR0713225Web.PageControllerTest do
  use ProjectR0713225Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end

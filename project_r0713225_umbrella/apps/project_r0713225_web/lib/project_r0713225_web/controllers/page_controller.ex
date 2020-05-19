defmodule ProjectR0713225Web.PageController do
  use ProjectR0713225Web, :controller

  def index(conn, _params) do
    render(conn, "index.html", role: "everyone")
  end

  def user_index(conn, _params) do
    render(conn, "index.html", role: "users")
  end

  def admin_index(conn, _params) do
    render(conn, "index.html", role: "admins")
  end

end

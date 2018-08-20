defmodule Userteam1Web.AuthHandler do
  use Userteam1Web, :controller

  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:error, "Authentication required")
    |> redirect(to: session_path(conn, :index))
  end
end

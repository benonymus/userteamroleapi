defmodule Userteam1Web.SessionController do
  use Userteam1Web, :controller
  alias Userteam1.Guardian

  def index(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"name" => name, "password" => password}}) do
    case Userteam1.Web.name_password_auth(name, password) do
      {:ok, user} ->
        IO.inspect(user)

        conn
        |> put_flash(:info, "Successfully signed in")
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid name or password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Successfully signed out")
    |> redirect(to: "/")
  end
end

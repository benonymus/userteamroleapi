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

        # change the ud to the super admin's id prob 3
        if user.role_id == 1 do
          conn
          |> put_flash(:info, "Successfully signed in!")
          |> Guardian.Plug.sign_in(user)
          |> redirect(to: page_path(conn, :index))
        else
          conn
          |> put_flash(:error, "No permission for this user!")
          |> render("new.html")
        end

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid name or password!")
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

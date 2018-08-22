defmodule Userteam1Web.ApiUserController do
  use Userteam1Web, :controller

  alias Userteam1.Web
  alias Userteam1.Web.User

  def sign_in(conn, %{"name" => name, "password" => password}) do
    case Userteam1.Web.token_sign_in(name, password) do
      {:ok, token, _claims} ->
        case Userteam1.Web.get_by_name(name) do
          {:ok, %User{} = user} ->
            conn |> render("userjwt.json", %{user: user, jwt: token})

          _ ->
            {:error, "User not found."}
        end

      _ ->
        {:error, :unauthorized}
    end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("user.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    # current_user = Guardian.Plug.current_resource(conn)
    user = Web.get_user!(id)

    case Web.update_user(user, user_params) do
      {:ok, user} ->
        render(conn, "user.json", user: user)
    end
  end
end

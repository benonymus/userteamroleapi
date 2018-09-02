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
    team_score = Userteam1Web.ApiTeamController.get_team_score(user)
    recording_list = Userteam1Web.RecordingController.get_recording_list(user)

    conn
    |> render(
      "user_with_team_score.json",
      user: user,
      team_score: team_score,
      recording_list: recording_list
    )
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

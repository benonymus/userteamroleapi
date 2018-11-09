defmodule Userteam1Web.ApiUserController do
  use Userteam1Web, :controller

  alias Userteam1.Web
  alias Userteam1.Web.User
  alias Userteam1Web.ApiTeamController
  alias Userteam1Web.RecordingController
  alias Userteam1.Guardian

  action_fallback(Userteam1Web.FallbackController)

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

  def validate(conn, %{"jwt" => jwt}) do
    user = Guardian.Plug.current_resource(conn)
    conn |> render("userjwt.json", %{user: user, jwt: jwt})
  end

  def index(conn, _params) do
    users = Web.list_users()

    users_with_scores =
      for user <- users do
        %{
          id: user.id,
          name: user.name,
          mod_score: RecordingController.get_mod_score_sum(user),
          num_of_recordings: RecordingController.get_number_of_rated_recordings(user),
          avatar: user.avatar
        }
      end

    render(conn, "index.json", users: users_with_scores)
  end

  # def show(conn, _params) do
  #   user = Guardian.Plug.current_resource(conn)
  #   team_score = ApiTeamController.get_team_score(user.team)
  #   recording_list = RecordingController.get_recording_list(user)
  #   mod_score_sum = RecordingController.get_mod_score_sum(user)
  #   num_of_recordings = RecordingController.get_number_of_rated_recordings(user)
  #
  #   conn
  #   |> render(
  #     "user_with_scores.json",
  #     user: user,
  #     team_score: team_score,
  #     recording_list: recording_list,
  #     mod_score_sum: mod_score_sum,
  #     num_of_recordings: num_of_recordings
  #   )
  # end

  def get_user_by_id(conn, %{"id" => id}) do
    user = Web.get_user!(id)
    logged_user = Guardian.Plug.current_resource(conn)
    team_score = ApiTeamController.get_team_score(user.team)
    recording_list = RecordingController.get_recording_list(user, logged_user)
    mod_score_sum = RecordingController.get_mod_score_sum(user)
    num_of_recordings = RecordingController.get_number_of_rated_recordings(user)

    conn
    |> render(
      "user_with_scores.json",
      user: user,
      team_score: team_score,
      recording_list: recording_list,
      mod_score_sum: mod_score_sum,
      num_of_recordings: num_of_recordings
    )
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Web.get_user!(id)
    logged_user = Guardian.Plug.current_resource(conn)

    case Web.update_user(user, user_params) do
      {:ok, user} ->
        team_score = ApiTeamController.get_team_score(user.team)
        recording_list = RecordingController.get_recording_list(user, logged_user)
        mod_score_sum = RecordingController.get_mod_score_sum(user)
        num_of_recordings = RecordingController.get_number_of_rated_recordings(user)

        conn
        |> render(
          "user_with_scores.json",
          user: user,
          team_score: team_score,
          recording_list: recording_list,
          mod_score_sum: mod_score_sum,
          num_of_recordings: num_of_recordings
        )
    end
  end
end

defmodule Userteam1Web.ApiUserController do
  use Userteam1Web, :controller

  alias Userteam1.Web
  alias Userteam1.Web.User
  alias Userteam1Web.ApiTeamController
  alias Userteam1Web.RecordingController

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

  def index(conn, _params) do
    users = Web.list_users()

    users_with_scores =
      for user <- users do
        %{
          name: user.name,
          mod_score: RecordingController.get_mod_score_sum(user),
          num_of_recordings: length(RecordingController.get_recording_list_scored(user))
        }
      end

    IO.inspect(users_with_scores)

    render(conn, "index.json", users: users_with_scores)
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    team_score = ApiTeamController.get_team_score(user.team)
    recording_list = RecordingController.get_recording_list(user)
    mod_score_sum = RecordingController.get_mod_score_sum(user)

    conn
    |> render(
      "user_with_team_score.json",
      user: user,
      team_score: team_score,
      recording_list: recording_list,
      mod_score_sum: mod_score_sum
    )
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    # current_user = Guardian.Plug.current_resource(conn)
    IO.puts("update hit")
    IO.inspect(user_params)

    test_params = %{
      "avatar" => %Plug.Upload{
        content_type: "image/jpeg",
        filename: "ConceptArt_SneakySneaky_011 (2).jpg",
        path: "/tmp/plug-1536/multipart-1536643366-594696545916483-1"
      }
    }

    IO.inspect(test_params)

    # xd = Poison.Parser.parse!()
    # IO.inspect(xd)
    user = Web.get_user!(id)

    case Web.update_user(user, test_params) do
      {:ok, user} ->
        render(conn, "user.json", user: user)
    end
  end
end

defmodule Userteam1Web.ApiTeamController do
  use Userteam1Web, :controller
  import Ecto.Query

  alias Userteam1.Repo
  alias Userteam1.Web
  alias Userteam1.Web.User
  alias Userteam1Web.RecordingController

  action_fallback(Userteam1Web.FallbackController)

  def get_team_score(team) do
    score_query =
      from(
        u in User,
        where: u.team_id == ^team.id,
        select: sum(u.score)
      )

    Repo.all(score_query)
  end

  def get_team_members(team) do
    members_query =
      from(
        u in User,
        where: u.team_id == ^team.id,
        select: u
      )

    Repo.all(members_query)
  end

  # edited for checking for role id is not teamlead
  def get_team_members_without_teamleader(team) do
    members_query =
      from(
        u in User,
        where: u.team_id == ^team.id and u.role_id != 2,
        select: u
      )

    Repo.all(members_query)
  end

  def index(conn, _params) do
    teams = Web.list_teams()

    teams_with_scores =
      for team <- teams do
        %{id: team.id, name: team.name, team_score: get_team_score(team)}
      end

    IO.inspect(teams_with_scores)

    render(conn, "index.json", teams: teams_with_scores)
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    team = Web.get_team!(user.team.id)
    team_score = get_team_score(team)
    team_members = get_team_members(team)
    team_recordings = RecordingController.get_recording_list_by_team_members(team_members)

    users_for_display =
      for user <- team_members do
        %{
          id: user.id,
          name: user.name,
          role_id: user.role_id,
          avatar: user.avatar,
          mod_score_sum: RecordingController.get_mod_score_sum(user),
          num_of_recordings: RecordingController.get_number_of_rated_recordings(user)
        }
      end

    conn
    |> render(
      "team.json",
      team: team,
      team_score: team_score,
      team_members: users_for_display,
      team_recordings: team_recordings
    )
  end

  def get_team_by_id(conn, %{"id" => id}) do
    logged_user = Guardian.Plug.current_resource(conn)
    team = Web.get_team!(id)
    team_score = get_team_score(team)
    team_members = get_team_members(team)
    team_recordings = RecordingController.get_recording_list_by_team_members(team_members)

    users_for_display =
      for user <- team_members do
        %{
          id: user.id,
          name: user.name,
          role_id: user.role_id,
          avatar: user.avatar,
          mod_score_sum: RecordingController.get_mod_score_sum(user),
          num_of_recordings: RecordingController.get_number_of_rated_recordings(user)
        }
      end

    team_recordings_with_ratings =
      for recording <- team_recordings do
        %{
          id: recording.id,
          challenge_id: recording.challenge_id,
          user_id: recording.user_id,
          name: recording.name,
          type: recording.type,
          text_input: recording.text_input,
          path_to_recording: recording.path_to_recording,
          comment: recording.comment,
          rating: RecordingController.get_recording_rating(recording.id, logged_user)
        }
      end

    conn
    |> render(
      "team.json",
      team: team,
      team_score: team_score,
      team_members: users_for_display,
      team_recordings: team_recordings_with_ratings
    )
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    # current_user = Guardian.Plug.current_resource(conn)
    team = Web.get_team!(id)

    case Web.update_team(team, team_params) do
      {:ok, team} ->
        render(conn, "team.json", team: team)
    end
  end
end

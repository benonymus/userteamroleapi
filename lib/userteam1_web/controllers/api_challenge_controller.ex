defmodule Userteam1Web.ApiChallengeController do
  use Userteam1Web, :controller
  alias Userteam1.Web
  alias Userteam1Web.ApiTeamController
  alias Userteam1Web.RecordingController

  action_fallback(Userteam1Web.FallbackController)

  def index(conn, _params) do
    challenges = Web.list_challenges()
    render(conn, "index.json", challenges: challenges)
  end

  def team_progres(conn, %{"challenge_id" => challenge_id}) do
    user = Guardian.Plug.current_resource(conn)
    team = Web.get_team!(user.team.id)
    team_members = ApiTeamController.get_team_members(team)

    team_recordings_by_challenge_id =
      RecordingController.get_recording_list_by_team_members_and_challeneg_id(
        team_members,
        challenge_id
      )

    team_recordings_user_ids =
      Enum.map(team_recordings_by_challenge_id, fn recording -> recording.user_id end)

    team_progress_percentage =
      length(team_recordings_by_challenge_id) / length(team_members) * 100

    users_for_display =
      for user <- team_members do
        %{
          id: user.id,
          name: user.name,
          done:
            if user.id in team_recordings_user_ids do
              true
            else
              false
            end
        }
      end

    render(
      conn,
      "team_progress.json",
      users: users_for_display,
      team_progress_percentage: team_progress_percentage
    )
  end

  # to use for gwtting the %
  # def show(conn, %{"id" => id}) do
  #   user = Guardian.Plug.current_resource(conn)
  #   challenge = Web.get_challenge!(id)
  #   recording_list = Userteam1Web.RecordingController.get_recording_list(user)
  #   IO.puts("list here")
  #   IO.inspect(recording_list)
  #   render(conn, "challenge.json", challenge: challenge)
  # end
end

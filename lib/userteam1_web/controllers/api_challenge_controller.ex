defmodule Userteam1Web.ApiChallengeController do
  use Userteam1Web, :controller
  import Ecto.Query

  alias Userteam1.Repo
  alias Userteam1.Web
  alias Userteam1.Web.Challenge
  alias Userteam1Web.ApiTeamController
  alias Userteam1Web.RecordingController

  action_fallback(Userteam1Web.FallbackController)

  defp get_challenges_by_challenge_group_id(challenge_group_id) do
    challenge_query =
      from(
        c in Challenge,
        where: c.challenge_group_id == ^challenge_group_id,
        select: c
      )

    Repo.all(challenge_query)
  end

  def get_challenge_list_by_challenge_group_id(conn, %{"challenge_group_id" => challenge_group_id}) do
    user = Guardian.Plug.current_resource(conn)
    recording_list = RecordingController.get_recording_list(user)

    recordings_challenge_ids =
      Enum.map(recording_list, fn recording -> recording.challenge_id end)

    challenges = get_challenges_by_challenge_group_id(challenge_group_id)

    today = Date.utc_today()

    challenges_to_display =
      for challenge <- challenges do
        xd = Date.diff(challenge.due_date, today)

        %{
          id: challenge.id,
          name: challenge.name,
          description:
            if challenge.description == nil || challenge.description == "" do
              "no description"
            else
              challenge.description
            end,
          hint:
            if challenge.hint == nil || challenge.hint == "" do
              "no hints for this one friend :)"
            else
              challenge.hint
            end,
          difficulty: challenge.difficulty,
          avatar: challenge.avatar,
          days_left:
            if xd >= 0 do
              xd
            else
              -1
            end,
          done_by_user:
            if challenge.id in recordings_challenge_ids do
              true
            else
              false
            end
        }
      end

    render(conn, "index.json", challenges: challenges_to_display)
  end

  def team_progres(conn, %{"challenge_id" => challenge_id}) do
    user = Guardian.Plug.current_resource(conn)
    team = Web.get_team!(user.team.id)
    team_members = ApiTeamController.get_team_members_without_teamleader(team)

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
          avatar: user.avatar,
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
end

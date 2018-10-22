defmodule Userteam1Web.ApiChallengeGroupController do
  use Userteam1Web, :controller
  import Ecto.Query

  alias Userteam1.Repo
  alias Userteam1.Web
  alias Userteam1.Web.Challenge
  alias Userteam1Web.ApiChallengeController
  alias Userteam1Web.RecordingController

  action_fallback(Userteam1Web.FallbackController)

  defp number_of_challanges(challenge_group_id) do
    challenge_query =
      from(
        c in Challenge,
        where: c.challenge_group_id == ^challenge_group_id,
        select: count(c.id)
      )

    Repo.all(challenge_query)
  end

  defp challanges_id_list(challenge_group_id) do
    challenge_query =
      from(
        c in Challenge,
        where: c.challenge_group_id == ^challenge_group_id,
        select: c.id
      )

    Repo.all(challenge_query)
  end

  def index(conn, _params) do
    challengegroups = Web.list_challengegroups()
    user = Guardian.Plug.current_resource(conn)
    recordings_challenge_ids = RecordingController.get_recording_list_challenge_ids(user)

    today = Date.utc_today()

    challenge_groups =
      for challengegroup <- challengegroups do
        num_of_challanges = number_of_challanges(challengegroup.id)
        challenges_id_list = challanges_id_list(challengegroup.id)

        challenges_expiartions =
          ApiChallengeController.get_challenges_expirations_by_challenge_group_id(
            challengegroup.id
          )

        checker = 0

        for date <- challenges_expiartions do
          xd = Date.compare(date, today)

          if xd == :gt do
            checker = checker + 1
          end
        end

        if num_of_challanges != 0 do
          %{
            id: challengegroup.id,
            name: challengegroup.name,
            avatar: challengegroup.avatar,
            number_of_challanges: List.first(num_of_challanges),
            done:
              if challenges_id_list in recordings_challenge_ids do
                true
              else
                false
              end,
            expired:
              if checker == length(challenges_expiartions) do
                true
              else
                false
              end
          }
        end
      end

    render(conn, "index.json", challenge_groups: challenge_groups)
  end
end

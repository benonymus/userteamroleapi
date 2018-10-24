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
        num_of_challenges = List.first(number_of_challanges(challengegroup.id))

        if num_of_challenges != 0 do
          challenges_id_list = challanges_id_list(challengegroup.id)

          challenges_expirations =
            ApiChallengeController.get_challenges_expirations_by_challenge_group_id(
              challengegroup.id
            )

          checker =
            Enum.all?(challenges_expirations, fn date -> Date.compare(date, today) == :lt end)

          %{
            id: challengegroup.id,
            name: challengegroup.name,
            avatar: challengegroup.avatar,
            number_of_challanges: num_of_challenges,
            done:
              if challenges_id_list in recordings_challenge_ids do
                true
              else
                false
              end,
            expired: checker
          }
        end
      end

    challenge_groups_filtered = Enum.filter(challenge_groups, &(!is_nil(&1)))

    IO.inspect(challenge_groups_filtered)

    render(conn, "index.json", challenge_groups: challenge_groups_filtered)
  end
end

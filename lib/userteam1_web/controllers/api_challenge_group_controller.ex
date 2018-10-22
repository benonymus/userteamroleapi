defmodule Userteam1Web.ApiChallengeGroupController do
  use Userteam1Web, :controller
  import Ecto.Query

  alias Userteam1.Repo
  alias Userteam1.Web
  alias Userteam1.Web.Challenge

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

  def index(conn, _params) do
    challengegroups = Web.list_challengegroups()
    IO.inspect(challengegroups)

    challenge_groups =
      for challengegroup <- challengegroups do
        num_of_challanges = number_of_challanges(challengegroup.id)

        if num_of_challanges != 0 do
          %{
            id: challengegroup.id,
            name: challengegroup.name,
            avatar: challengegroup.avatar,
            number_of_challanges: List.first(num_of_challanges)
          }
        end
      end

    IO.inspect(challenge_groups)

    render(conn, "index.json", challenge_groups: challenge_groups)
  end
end

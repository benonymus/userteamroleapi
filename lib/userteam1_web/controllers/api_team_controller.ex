defmodule Userteam1Web.ApiTeamController do
  use Userteam1Web, :controller
  import Ecto.Query

  alias Userteam1.Repo
  alias Userteam1.Web
  alias Userteam1.Web.User

  def get_team_score(user) do
    team = Web.get_team!(user.team.id)

    score_query =
      from(
        u in User,
        where: u.team_id == ^team.id,
        select: sum(u.score)
      )

    Repo.all(score_query)
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    team = Web.get_team!(user.team.id)
    team_score = get_team_score(user)

    conn |> render("team.json", team: team, team_score: team_score)
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

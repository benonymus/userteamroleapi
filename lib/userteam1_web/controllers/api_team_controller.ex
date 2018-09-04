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

  def get_team_members(team) do
    score_query =
      from(
        u in User,
        where: u.team_id == ^team.id,
        select: u
      )

    Repo.all(score_query)
  end

  def index(conn, _params) do
    teams = Web.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    team = Web.get_team!(user.team.id)
    team_score = get_team_score(user)
    team_members = get_team_members(team)
    IO.inspect(team_members)

    conn |> render("team.json", team: team, team_score: team_score, team_members: team_members)
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

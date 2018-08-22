defmodule Userteam1Web.ApiTeamController do
  use Userteam1Web, :controller

  alias Userteam1.Web

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    team = Web.get_team!(user.team.id)
    conn |> render("team.json", team: team)
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

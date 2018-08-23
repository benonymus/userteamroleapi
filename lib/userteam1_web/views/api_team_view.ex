defmodule Userteam1Web.ApiTeamView do
  use Userteam1Web, :view

  def render("team.json", %{team: team, team_score: team_score}) do
    %{
      id: team.id,
      name: team.name,
      team_score: team_score
    }
  end
end

defmodule Userteam1Web.ApiTeamView do
  use Userteam1Web, :view

  def render("team.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name
    }
  end
end

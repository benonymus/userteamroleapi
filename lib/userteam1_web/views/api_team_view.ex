defmodule Userteam1Web.ApiTeamView do
  use Userteam1Web, :view
  alias Userteam1Web.ApiTeamView
  alias Userteam1Web.ApiUserView
  alias Userteam1Web.RecordingView

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, ApiTeamView, "teamx.json", as: :team)}
  end

  def render("teamx.json", %{team: team}) do
    %{
      # id: team.id,
      name: team.name,
      team_score: List.first(team.team_score)
    }
  end

  def render("team.json", %{
        team: team,
        team_score: team_score,
        team_members: team_members,
        team_recordings: team_recordings
      }) do
    %{
      id: team.id,
      name: team.name,
      team_score: List.first(team_score),
      team_members: render_many(team_members, ApiUserView, "team_member.json", as: :user),
      team_recordings:
        if team_recordings == nil do
          "no recordings yet"
        else
          render_many(team_recordings, RecordingView, "recording.json", as: :recording)
        end
    }
  end
end

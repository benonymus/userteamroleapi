defmodule Userteam1Web.ApiUserView do
  use Userteam1Web, :view
  alias Userteam1Web.ApiUserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, ApiUserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      password_hash: user.password_hash,
      team:
        if user.team == nil do
          "no team"
        else
          user.team.name
        end,
      score: user.score
    }
  end

  def render("user_with_team_score.json", %{user: user, team_score: team_score}) do
    %{
      id: user.id,
      name: user.name,
      password_hash: user.password_hash,
      team:
        if user.team == nil do
          "no team"
        else
          user.team.name
        end,
      score: user.score,
      team_score: team_score
    }
  end

  def render("userjwt.json", %{user: user, jwt: jwt}) do
    %{id: user.id, name: user.name, token: jwt}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{token: jwt}
  end
end

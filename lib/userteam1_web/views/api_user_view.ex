defmodule Userteam1Web.ApiUserView do
  use Userteam1Web, :view
  alias Userteam1Web.ApiUserView
  alias Userteam1Web.RecordingView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, ApiUserView, "user_with_mod_score.json", as: :user)}
  end

  def render("user_with_mod_score.json", %{user: user}) do
    %{
      name: user.name,
      num_of_recordings: user.num_of_recordings,
      mod_score:
        if List.first(user.mod_score) == nil do
          0
        else
          List.first(user.mod_score) / user.num_of_recordings
        end
    }
  end

  def render("user_with_done.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      done: user.done
    }
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

  def render("team_member.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      score: user.score
    }
  end

  def render("user_with_team_score.json", %{
        user: user,
        team_score: team_score,
        recording_list: recording_list,
        mod_score_sum: mod_score_sum
      }) do
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
      team_score: team_score,
      recording_list:
        if is_nil(recording_list) do
          "no recordings"
        else
          render_many(recording_list, RecordingView, "recording.json", as: :recording)
        end,
      mod_score_sum: mod_score_sum
    }
  end

  def render("userjwt.json", %{user: user, jwt: jwt}) do
    %{id: user.id, name: user.name, token: jwt}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{token: jwt}
  end
end

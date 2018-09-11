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
      done: user.done,
      avatar: render_image_url(user)
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
      score: user.score,
      avatar: render_image_url(user)
    }
  end

  def render("team_member.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      avatar: render_image_url(user)
    }
  end

  def render("user_with_scores.json", %{
        user: user,
        team_score: team_score,
        recording_list: recording_list,
        mod_score_sum: mod_score_sum,
        num_of_recordings: num_of_recordings
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
      team_score: List.first(team_score),
      recording_list:
        if is_nil(recording_list) do
          "no recordings"
        else
          render_many(recording_list, RecordingView, "recording.json", as: :recording)
        end,
      mod_score_sum:
        if List.first(mod_score_sum) == nil do
          0
        else
          List.first(mod_score_sum)
        end,
      avatar: render_image_url(user),
      num_of_recordings: num_of_recordings
    }
  end

  def render("userjwt.json", %{user: user, jwt: jwt}) do
    %{id: user.id, name: user.name, token: jwt}
  end

  def render("jwt.json", %{jwt: jwt}) do
    %{token: jwt}
  end

  def render_image_url(user) do
    if user.avatar != nil do
      Userteam1Web.Avatar.url({user.avatar, user}, :original)
    else
      nil
    end
  end
end

defmodule Userteam1Web.ApiChallengeView do
  use Userteam1Web, :view
  alias Userteam1Web.ApiChallengeView
  alias Userteam1Web.ApiUserView

  def render("index.json", %{challenges: challenges}) do
    %{data: render_many(challenges, ApiChallengeView, "challenge.json", as: :challenge)}
  end

  def render("challenge.json", %{challenge: challenge}) do
    %{
      id: challenge.id,
      name: challenge.name,
      description:
        if challenge.description == nil do
          "no description"
        else
          challenge.description
        end,
      hint:
        if challenge.hint == nil do
          "no hint for this challenge"
        else
          challenge.hint
        end,
      text_input: challenge.text_input,
      audio_input: challenge.audio_input,
      photo_input: challenge.photo_input,
      difficulty: challenge.difficulty,
      avatar: render_image_url(challenge),
      days_left: challenge.days_left,
      done_by_user: challenge.done_by_user
    }
  end

  def render("team_progress.json", %{
        users: users,
        team_progress_percentage: team_progress_percentage
      }) do
    %{
      team_progress_percentage: team_progress_percentage,
      users: render_many(users, ApiUserView, "user_with_done.json", as: :user)
    }
  end

  defp render_image_url(challenge) do
    if challenge.avatar != nil do
      Userteam1Web.ChallengeAvatar.url({challenge.avatar, challenge}, :thumb)
    else
      nil
    end
  end
end

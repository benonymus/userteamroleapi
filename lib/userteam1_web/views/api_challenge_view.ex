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
      difficulty: challenge.difficulty,
      avatar: render_image_url(challenge)
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
      Userteam1Web.ChallengeAvatar.url({challenge.avatar, challenge}, :original)
    else
      nil
    end
  end
end

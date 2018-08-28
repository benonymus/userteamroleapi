defmodule Userteam1Web.ApiChallengeView do
  use Userteam1Web, :view
  alias Userteam1Web.ApiChallengeView

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
      difficulty: challenge.difficulty
    }
  end
end

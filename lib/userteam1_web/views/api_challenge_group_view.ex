defmodule Userteam1Web.ApiChallengeGroupView do
  use Userteam1Web, :view
  alias Userteam1Web.ApiChallengeGroupView

  def render("index.json", %{challenge_groups: challenge_groups}) do
    %{
      data:
        render_many(challenge_groups, ApiChallengeGroupView, "challenge_group.json",
          as: :challenge_group
        )
    }
  end

  def render("challenge_group.json", %{challenge_group: challenge_group}) do
    %{
      id: challenge_group.id,
      name: challenge_group.name,
      number_of_challanges: challenge_group.number_of_challanges,
      avatar: render_image_url(challenge)
    }
  end

  defp render_image_url(chachallenge_groupllenge) do
    if challenge_group.avatar != nil do
      Userteam1Web.ChallengeGroupAvatar.url({challenge_group.avatar, challenge_group}, :original)
    else
      nil
    end
  end
end

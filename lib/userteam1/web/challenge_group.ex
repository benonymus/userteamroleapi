defmodule Userteam1.Web.ChallengeGroup do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "challengegroups" do
    field(:name, :string)
    field(:avatar, Userteam1Web.ChallengeGroupAvatar.Type)
    has_many(:challenges, Userteam1.Web.Challenge)

    timestamps()
  end

  @doc false
  def changeset(challenge_group, attrs) do
    challenge_group
    |> cast(attrs, [:name])
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end

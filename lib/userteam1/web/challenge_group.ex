defmodule Userteam1.Web.ChallengeGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "challengegroups" do
    field(:name, :string)
    has_many(:challenges, Userteam1.Web.Challenge)

    timestamps()
  end

  @doc false
  def changeset(challenge_group, attrs) do
    challenge_group
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end

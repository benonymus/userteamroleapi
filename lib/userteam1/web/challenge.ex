defmodule Userteam1.Web.Challenge do
  use Ecto.Schema
  import Ecto.Changeset

  schema "challenges" do
    field(:name, :string)
    field(:description, :string)
    field(:difficulty, :integer, default: 1)

    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:name, :description, :difficulty])
    |> validate_required([:name, :difficulty])
  end
end

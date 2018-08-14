defmodule Userteam1.Team do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field(:name, :string)
    has_many(:users, Userteam1.User)
    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

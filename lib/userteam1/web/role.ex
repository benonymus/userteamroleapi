defmodule Userteam1.Web.Role do
  use Ecto.Schema
  import Ecto.Changeset

  schema "roles" do
    field(:name, :string)
    has_many(:users, Userteam1.Web.User)

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end

defmodule Userteam1.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:name, :string)
    field(:password, :string)
    # field(:role, :string)
    belongs_to(:role, Userteam1.Role)
    # field(:team_id, :integer)
    # belongs_to(:team, Userteam1.Team, define_field: false)
    belongs_to(:team, Userteam1.Team)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :role_id, :team_id])
    |> validate_required([:name, :password, :role_id, :team_id])
  end
end

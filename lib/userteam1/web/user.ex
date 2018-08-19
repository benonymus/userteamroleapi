defmodule Userteam1.Web.User do
  use Ecto.Schema
  import Ecto.Changeset

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field(:name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    belongs_to(:role, Userteam1.Role)
    belongs_to(:team, Userteam1.Team)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :role_id, :team_id])
    |> validate_required([:name, :password, :role_id])
    |> unique_constraint(:name)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end

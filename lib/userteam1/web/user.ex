defmodule Userteam1.Web.User do
  use Ecto.Schema
  import Ecto.Changeset

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field(:name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:score, :integer, default: 0)
    belongs_to(:role, Userteam1.Web.Role)
    belongs_to(:team, Userteam1.Web.Team)
    has_many(:recording, Userteam1.Web.Recording)
    has_many(:comment, Userteam1.Web.Comment)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :role_id, :team_id, :score])
    |> validate_required([:name, :role_id])
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

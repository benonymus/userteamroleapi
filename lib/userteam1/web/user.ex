defmodule Userteam1.Web.User do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  schema "users" do
    field(:name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    field(:score, :integer, default: 0)
    field(:avatar, Userteam1Web.Avatar.Type)
    belongs_to(:role, Userteam1.Web.Role)
    belongs_to(:team, Userteam1.Web.Team)
    has_many(:recording, Userteam1.Web.Recording, on_delete: :nilify_all)
    has_many(:comment, Userteam1.Web.Comment, on_delete: :nilify_all)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password, :role_id, :team_id, :score])
    |> cast_attachments(attrs, [:avatar])
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

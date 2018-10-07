defmodule Userteam1.Web.Challenge do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "challenges" do
    field(:name, :string)
    field(:avatar, Userteam1Web.ChallengeAvatar.Type)
    field(:description, :string)
    field(:hint, :string)
    field(:difficulty, :integer)
    field(:due_date, :date)
    has_many(:recording, Userteam1.Web.Recording)
    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [:name, :description, :hint, :difficulty, :due_date])
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:name, :difficulty])
  end
end

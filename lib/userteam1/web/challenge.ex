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
    belongs_to(:challenge_group, Userteam1.Web.ChallengeGroup)
    has_many(:recording, Userteam1.Web.Recording)
    timestamps()
  end

  @doc false
  def changeset(challenge, attrs) do
    challenge
    |> cast(attrs, [
      :name,
      :description,
      :challenge_group_id,
      :hint,
      :difficulty,
      :due_date
    ])
    |> cast_attachments(attrs, [:avatar])
    |> validate_required([:name, :difficulty])
  end
end

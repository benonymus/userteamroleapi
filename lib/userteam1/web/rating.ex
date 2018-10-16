defmodule Userteam1.Web.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field(:amount, :integer)
    belongs_to(:user, Userteam1.Web.User)
    belongs_to(:recording, Userteam1.Web.Recording)

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:amount, :user_id, :recording_id])
    |> validate_required([:amount, :user_id, :recording_id])
  end
end

defmodule Userteam1.Web.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field(:message, :string)
    belongs_to(:user, Userteam1.Web.User)
    belongs_to(:recording, Userteam1.Web.Recording)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:message, :user_id, :recording_id])
    |> validate_required([:message])
  end
end

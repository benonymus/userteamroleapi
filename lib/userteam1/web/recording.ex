defmodule Userteam1.Web.Recording do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "recordings" do
    field(:path_to_recording, Userteam1Web.Recording.Type)
    belongs_to(:user, Userteam1.Web.User)
    belongs_to(:challenge, Userteam1.Web.Challenge)
    has_many(:comment, Userteam1.Web.Comment)
    has_many(:rating, Userteam1.Web.Rating)

    timestamps()
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [:challenge_id, :user_id])
    |> cast_attachments(attrs, [:path_to_recording])
    |> validate_required([:path_to_recording])
  end
end

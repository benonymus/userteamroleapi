defmodule Userteam1.Web.Recording do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recordings" do
    field(:path_to_recording, :string)
    field(:mod_score, :integer)
    belongs_to(:user, Userteam1.Web.User)
    belongs_to(:challenge, Userteam1.Web.Challenge)
    has_many(:comment, Userteam1.Web.Comment)

    timestamps()
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [:path_to_recording, :challenge_id, :user_id, :mod_score])
    |> validate_required([:path_to_recording])
  end
end

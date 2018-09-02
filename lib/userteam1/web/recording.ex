defmodule Userteam1.Web.Recording do
  use Ecto.Schema
  import Ecto.Changeset

  schema "recordings" do
    field(:path_to_recording, :string)
    field(:challenge_id, :integer)
    belongs_to(:user, Userteam1.Web.User)

    timestamps()
  end

  @doc false
  def changeset(recording, attrs) do
    recording
    |> cast(attrs, [:path_to_recording, :challenge_id, :user_id])
    |> validate_required([:path_to_recording])
  end
end

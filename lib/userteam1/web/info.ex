defmodule Userteam1.Web.Info do
  use Ecto.Schema
  import Ecto.Changeset


  schema "infos" do
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(info, attrs) do
    info
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end

defmodule Userteam1.Repo.Migrations.CreateInfos do
  use Ecto.Migration

  def change do
    create table(:infos) do
      add(:content, :text)

      timestamps()
    end
  end
end

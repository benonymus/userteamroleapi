defmodule Userteam1.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      add(:password, :string)
      add(:role_id, references(:roles))
      add(:team_id, references(:teams))

      timestamps()
    end
  end
end

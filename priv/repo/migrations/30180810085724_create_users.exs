defmodule Userteam1.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)
      add(:avatar, :string)
      add(:password_hash, :string)
      add(:score, :integer)
      add(:role_id, references(:roles))
      add(:team_id, references(:teams))

      timestamps()
    end

    create(unique_index(:users, [:name]))
  end
end

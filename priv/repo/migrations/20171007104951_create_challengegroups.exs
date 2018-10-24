defmodule Userteam1.Repo.Migrations.CreateChallengegroups do
  use Ecto.Migration

  def change do
    create table(:challengegroups) do
      add(:name, :string)
      add(:avatar, :string)

      timestamps()
    end

    create(unique_index(:challengegroups, [:name]))
  end
end

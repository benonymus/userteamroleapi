defmodule Userteam1.Repo.Migrations.CreateChallenges do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add :name, :string
      add :description, :string
      add :difficulty, :integer

      timestamps()
    end

  end
end

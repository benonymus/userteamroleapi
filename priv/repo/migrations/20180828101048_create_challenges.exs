defmodule Userteam1.Repo.Migrations.CreateChallenges do
  use Ecto.Migration

  def change do
    create table(:challenges) do
      add(:name, :string)
      add(:avatar, :string)
      add(:description, :text)
      add(:hint, :text)
      add(:difficulty, :integer)
      add(:due_date, :date)

      timestamps()
    end
  end
end

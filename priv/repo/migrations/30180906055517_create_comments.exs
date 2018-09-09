defmodule Userteam1.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add(:message, :string)
      add(:user_id, references(:users))
      add(:recording_id, references(:recordings))

      timestamps()
    end
  end
end

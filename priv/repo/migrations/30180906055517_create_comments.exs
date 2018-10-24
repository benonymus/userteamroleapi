defmodule Userteam1.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add(:message, :string)
      add(:user_id, references(:users, on_delete: :delete_all))
      add(:recording_id, references(:recordings, on_delete: :delete_all))

      timestamps()
    end
  end
end

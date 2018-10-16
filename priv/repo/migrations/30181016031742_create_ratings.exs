defmodule Userteam1.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add(:amount, :integer)
      add(:user_id, references(:users, on_delete: :delete_all))
      add(:recording_id, references(:recordings, on_delete: :delete_all))

      timestamps()
    end
  end
end

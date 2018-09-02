defmodule Userteam1.Repo.Migrations.CreateRecordings do
  use Ecto.Migration

  def change do
    create table(:recordings) do
      add(:path_to_recording, :string)
      add(:challenge_id, :integer)
      add(:user_id, references(:users))
      timestamps()
    end

    create(unique_index(:recordings, [:path_to_recording]))
  end
end

defmodule Userteam1.Repo.Migrations.CreateRecordings do
  use Ecto.Migration

  def change do
    create table(:recordings) do
      add(:path_to_recording, :string)
      add(:mod_score, :integer)
      add(:user_id, references(:users, on_delete: :delete_all))
      add(:challenge_id, references(:challenges, on_delete: :delete_all))
      timestamps()
    end

    create(unique_index(:recordings, [:path_to_recording]))
  end
end

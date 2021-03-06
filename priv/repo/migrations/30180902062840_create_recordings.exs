defmodule Userteam1.Repo.Migrations.CreateRecordings do
  use Ecto.Migration

  def change do
    create table(:recordings) do
      add(:name, :string)
      add(:type, :string)
      add(:path_to_recording, :string)
      add(:text_input, :text)
      add(:user_id, references(:users, on_delete: :delete_all))
      add(:challenge_id, references(:challenges, on_delete: :delete_all))
      timestamps()
    end
  end
end

defmodule Userteam1.Repo.Migrations.CreateRoles do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string

      timestamps()
    end

  end
end

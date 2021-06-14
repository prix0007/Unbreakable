defmodule Unbreakable.Repo.Migrations.CreateStreaks do
  use Ecto.Migration

  def change do
    create table(:streaks) do
      add :length, :integer
      add :goal_id, references(:goals, on_delete: :delete_all)

      timestamps()
    end

    create index(:streaks, [:goal_id])
  end
end

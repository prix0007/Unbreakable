defmodule Unbreakable.Repo.Migrations.CreateStatuses do
  use Ecto.Migration

  def change do
    create table(:statuses) do
      add :date, :date
      add :is_complete, :boolean, default: false, null: false
      add :goal_id, references(:goals, on_delete: :delete_all)

      timestamps()
    end

    create index(:statuses, [:goal_id])
  end
end

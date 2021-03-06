defmodule Unbreakable.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :title, :string
      add :is_active, :boolean, default: true, null: false
      add :streak, :integer, default: 0, null: false

      timestamps()
    end

    create index(:goals, [:title, :streak])

  end
end

defmodule Unbreakable.Core.Streak do
  use Ecto.Schema
  import Ecto.Changeset

  schema "streaks" do
    field :length, :integer
    belongs_to :goal, Unbreakable.Core.Goal

    timestamps()
  end

  @doc false
  def changeset(streak, attrs) do
    streak
    |> cast(attrs, [:length, :goal_id])
    |> validate_required([:length, :goal_id])
  end
end

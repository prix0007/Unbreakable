defmodule Unbreakable.Core.Streak do
  use Ecto.Schema
  import Ecto.Changeset

  schema "streaks" do
    field :length, :integer
    field :goal_id, :id

    timestamps()
  end

  @doc false
  def changeset(streak, attrs) do
    streak
    |> cast(attrs, [:length, :goal_id])
    |> validate_required([:length, :goal_id])
  end
end

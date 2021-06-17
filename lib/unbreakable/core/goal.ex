defmodule Unbreakable.Core.Goal do
  use Ecto.Schema
  import Ecto.Changeset
  alias Unbreakable.Core.{Status, Streak}

  schema "goals" do
    field :is_active, :boolean, default: true
    field :title, :string
    has_many :statuses, Status
    has_many :streaks, Streak
    # field :streak, :integer, default: 0

    timestamps()
  end

  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:title, :is_active, :streak])
    |> validate_required([:title, :is_active])
  end
end

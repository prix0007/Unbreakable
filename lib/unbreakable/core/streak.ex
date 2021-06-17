defmodule Unbreakable.Core.Streak do
  use Ecto.Schema
  alias Unbreakable.Core.Goal

  @primary_key false
  schema "streaks" do
    field :start, :date
    field :end, :date
    field :length, :integer, default: 0
    belongs_to :goal, Goal
  end

end

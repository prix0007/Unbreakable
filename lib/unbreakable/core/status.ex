defmodule Unbreakable.Core.Status do
  use Ecto.Schema
  import Ecto.Changeset

  schema "statuses" do
    field :date, :date
    field :is_complete, :boolean, default: false
    belongs_to :goal, Unbreakable.Core.Goal

    timestamps()
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:date, :is_complete, :goal_id])
    |> validate_required([:date, :is_complete, :goal_id])
  end
end

defmodule Unbreakable.Core.Status do
  use Ecto.Schema
  import Ecto.Changeset

  schema "statuses" do
    field :complete, :boolean, default: false
    field :date, :date
    field :goal_id, :id

    timestamps()
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:date, :complete, :goal_id])
    |> validate_required([:date, :complete, :goal_id])
  end
end

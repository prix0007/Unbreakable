defmodule Unbreakable.Core.Goal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "goals" do
    field :is_active, :boolean, default: true
    field :title, :string
    has_many :statuses, Unbreakable.Core.Status
    field :streak, :integer, default: 0

    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:title, :is_active, :streak])
    |> validate_required([:title, :is_active])
  end
end

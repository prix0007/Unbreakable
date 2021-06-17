defmodule Unbreakable.Core do
  @moduledoc """
  The Core context.
  """

  import Ecto.Query, warn: false
  alias Unbreakable.Repo

  alias Unbreakable.Core.{Goal, Streak}

  @doc """
  Returns the list of goals.

  ## Examples

      iex> list_goals()
      [%Goal{}, ...]

  """
  def list_goals do
    Goal
    |> order_by(:id)
    |>Repo.all()
    |> Repo.preload([
      :statuses,
      streaks: (from s in Streak, order_by: [desc: :end])
    ])

  end

  @doc """
  Gets a single goal.

  Raises `Ecto.NoResultsError` if the Goal does not exist.

  ## Examples

      iex> get_goal!(123)
      %Goal{}

      iex> get_goal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_goal!(id) do
    Repo.get!(Goal, id) |> Repo.preload([:statuses, :streaks])
  end
  @doc """
  Creates a goal.

  ## Examples

      iex> create_goal(%{field: value})
      {:ok, %Goal{}}

      iex> create_goal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_goal(attrs \\ %{}) do
    %Goal{}
    |> Goal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a goal.

  ## Examples

      iex> update_goal(goal, %{field: new_value})
      {:ok, %Goal{}}

      iex> update_goal(goal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_goal(%Goal{} = goal, attrs) do
    goal
    |> Goal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a goal.

  ## Examples

      iex> delete_goal(goal)
      {:ok, %Goal{}}

      iex> delete_goal(goal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_goal(%Goal{} = goal) do
    Repo.delete(goal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking goal changes.

  ## Examples

      iex> change_goal(goal)
      %Ecto.Changeset{data: %Goal{}}

  """
  def change_goal(%Goal{} = goal, attrs \\ %{}) do
    Goal.changeset(goal, attrs)
  end

  alias Unbreakable.Core.Status

  @doc """
  Returns the list of statuses.

  ## Examples

      iex> list_statuses()
      [%Status{}, ...]

  """
  def list_statuses do
    Repo.all(Status) |> Repo.preload(:goal)
  end

  @doc """
  Gets a single status.

  Raises `Ecto.NoResultsError` if the Status does not exist.

  ## Examples

      iex> get_status!(123)
      %Status{}

      iex> get_status!(456)
      ** (Ecto.NoResultsError)

  """
  def get_status!(id), do: Repo.get!(Status, id)

  @doc """
  Creates a status.

  ## Examples

      iex> create_status(%{field: value})
      {:ok, %Status{}}

      iex> create_status(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_status(attrs \\ %{}) do
    %Status{}
    |> Status.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a status.

  ## Examples

      iex> update_status(status, %{field: new_value})
      {:ok, %Status{}}

      iex> update_status(status, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_status(%Status{} = status, attrs) do
    status
    |> Status.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a status.

  ## Examples

      iex> delete_status(status)
      {:ok, %Status{}}

      iex> delete_status(status)
      {:error, %Ecto.Changeset{}}

  """
  def delete_status(%Status{} = status) do
    Repo.delete(status)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking status changes.

  ## Examples

      iex> change_status(status)
      %Ecto.Changeset{data: %Status{}}

  """
  def change_status(%Status{} = status, attrs \\ %{}) do
    Status.changeset(status, attrs)
  end

  # def reset_streak(%Goal{} = goal), do: update_goal(goal, %{streak: 0})

  # def reset_streak(%Status{} = status) do
  #   goal = get_goal!(status.goal_id)
  #   update_goal(goal, %{streak: 0})
  # end

  # def increment_streak(%Goal{} = goal) do
  #   goal_query = from Goal, where: [id: ^goal.id]
  #   Repo.update_all(goal_query, inc: [streak: 1])
  # end

  # def increment_streak(%Status{} = status) do
  #   goal_query = from Goal, where: [id: ^status.goal_id]
  #   Repo.update_all(goal_query, inc: [streak: 1])
  # end

  def list_streaks do
    Repo.all(Streak)
  end

  # Queries to get a single streak from the DB
  # Expensive to use for a listing of goals
  def current_streak(goal_id) do
    today = Date.utc_today()
    case newest_streak(goal_id) do
      %Streak{end: ^today, length: len} -> len
      _ -> 0
    end
  end

  def newest_streak(goal_id) do
    query = from s in Streak,
    where: s.goal_id == ^goal_id,
    preload: :goal,
    order_by: [desc: s.end],
    limit: 1
    Repo.one!(query)
  end

  def longest_streak(goal_id) do
    query = from s in Streak,
    where: s.goal_id == ^goal_id,
    preload: :goal,
    order_by: [desc: s.length],
    limit: 1
    Repo.one!(query)
  end

end

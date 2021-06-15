defmodule Unbreakable.Core do
  @moduledoc """
  The Core context.
  """

  import Ecto.Query, warn: false
  alias Unbreakable.Repo

  alias Unbreakable.Core.Goal

  @doc """
  Returns the list of goals.

  ## Examples

      iex> list_goals()
      [%Goal{}, ...]

  """
  def list_goals do
    Repo.all(Goal) |> Repo.preload([:statuses, :streak])
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
    Repo.get!(Goal, id) |> Repo.preload([:statuses, :streak])
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

  alias Unbreakable.Core.Streak

  @doc """
  Returns the list of streaks.

  ## Examples

      iex> list_streaks()
      [%Streak{}, ...]

  """
  def list_streaks do
    Repo.all(Streak)
  end

  @doc """
  Gets a single streak.

  Raises `Ecto.NoResultsError` if the Streak does not exist.

  ## Examples

      iex> get_streak!(123)
      %Streak{}

      iex> get_streak!(456)
      ** (Ecto.NoResultsError)

  """
  def get_streak!(id), do: Repo.get!(Streak, id)

  @doc """
  Creates a streak.

  ## Examples

      iex> create_streak(%{field: value})
      {:ok, %Streak{}}

      iex> create_streak(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_streak(attrs \\ %{}) do
    %Streak{}
    |> Streak.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a streak.

  ## Examples

      iex> update_streak(streak, %{field: new_value})
      {:ok, %Streak{}}

      iex> update_streak(streak, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_streak(%Streak{} = streak, attrs) do
    streak
    |> Streak.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a streak.

  ## Examples

      iex> delete_streak(streak)
      {:ok, %Streak{}}

      iex> delete_streak(streak)
      {:error, %Ecto.Changeset{}}

  """
  def delete_streak(%Streak{} = streak) do
    Repo.delete(streak)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking streak changes.

  ## Examples

      iex> change_streak(streak)
      %Ecto.Changeset{data: %Streak{}}

  """
  def change_streak(%Streak{} = streak, attrs \\ %{}) do
    Streak.changeset(streak, attrs)
  end

  alias Unbreakable.Core.Status

  @doc """
  Returns the list of statuses.

  ## Examples

      iex> list_statuses()
      [%Status{}, ...]

  """
  def list_statuses do
    Repo.all(Status)
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
end

defmodule Unbreakable.CoreTest do
  use Unbreakable.DataCase

  alias Unbreakable.Core

  describe "goals" do
    alias Unbreakable.Core.Goal

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def goal_fixture(attrs \\ %{}) do
      {:ok, goal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_goal()

      goal
    end

    test "list_goals/0 returns all goals" do
      goal = goal_fixture()
      assert Core.list_goals() == [goal]
    end

    test "get_goal!/1 returns the goal with given id" do
      goal = goal_fixture()
      assert Core.get_goal!(goal.id) == goal
    end

    test "create_goal/1 with valid data creates a goal" do
      assert {:ok, %Goal{} = goal} = Core.create_goal(@valid_attrs)
      assert goal.title == "some title"
    end

    test "create_goal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_goal(@invalid_attrs)
    end

    test "update_goal/2 with valid data updates the goal" do
      goal = goal_fixture()
      assert {:ok, %Goal{} = goal} = Core.update_goal(goal, @update_attrs)
      assert goal.title == "some updated title"
    end

    test "update_goal/2 with invalid data returns error changeset" do
      goal = goal_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_goal(goal, @invalid_attrs)
      assert goal == Core.get_goal!(goal.id)
    end

    test "delete_goal/1 deletes the goal" do
      goal = goal_fixture()
      assert {:ok, %Goal{}} = Core.delete_goal(goal)
      assert_raise Ecto.NoResultsError, fn -> Core.get_goal!(goal.id) end
    end

    test "change_goal/1 returns a goal changeset" do
      goal = goal_fixture()
      assert %Ecto.Changeset{} = Core.change_goal(goal)
    end
  end

  describe "streaks" do
    alias Unbreakable.Core.Streak

    @valid_attrs %{length: 42}
    @update_attrs %{length: 43}
    @invalid_attrs %{length: nil}

    def streak_fixture(attrs \\ %{}) do
      {:ok, streak} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_streak()

      streak
    end

    test "list_streaks/0 returns all streaks" do
      streak = streak_fixture()
      assert Core.list_streaks() == [streak]
    end

    test "get_streak!/1 returns the streak with given id" do
      streak = streak_fixture()
      assert Core.get_streak!(streak.id) == streak
    end

    test "create_streak/1 with valid data creates a streak" do
      assert {:ok, %Streak{} = streak} = Core.create_streak(@valid_attrs)
      assert streak.length == 42
    end

    test "create_streak/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_streak(@invalid_attrs)
    end

    test "update_streak/2 with valid data updates the streak" do
      streak = streak_fixture()
      assert {:ok, %Streak{} = streak} = Core.update_streak(streak, @update_attrs)
      assert streak.length == 43
    end

    test "update_streak/2 with invalid data returns error changeset" do
      streak = streak_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_streak(streak, @invalid_attrs)
      assert streak == Core.get_streak!(streak.id)
    end

    test "delete_streak/1 deletes the streak" do
      streak = streak_fixture()
      assert {:ok, %Streak{}} = Core.delete_streak(streak)
      assert_raise Ecto.NoResultsError, fn -> Core.get_streak!(streak.id) end
    end

    test "change_streak/1 returns a streak changeset" do
      streak = streak_fixture()
      assert %Ecto.Changeset{} = Core.change_streak(streak)
    end
  end

  describe "statuses" do
    alias Unbreakable.Core.Status

    @valid_attrs %{complete: true, date: ~D[2010-04-17]}
    @update_attrs %{complete: false, date: ~D[2011-05-18]}
    @invalid_attrs %{complete: nil, date: nil}

    def status_fixture(attrs \\ %{}) do
      {:ok, status} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_status()

      status
    end

    test "list_statuses/0 returns all statuses" do
      status = status_fixture()
      assert Core.list_statuses() == [status]
    end

    test "get_status!/1 returns the status with given id" do
      status = status_fixture()
      assert Core.get_status!(status.id) == status
    end

    test "create_status/1 with valid data creates a status" do
      assert {:ok, %Status{} = status} = Core.create_status(@valid_attrs)
      assert status.complete == true
      assert status.date == ~D[2010-04-17]
    end

    test "create_status/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_status(@invalid_attrs)
    end

    test "update_status/2 with valid data updates the status" do
      status = status_fixture()
      assert {:ok, %Status{} = status} = Core.update_status(status, @update_attrs)
      assert status.complete == false
      assert status.date == ~D[2011-05-18]
    end

    test "update_status/2 with invalid data returns error changeset" do
      status = status_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_status(status, @invalid_attrs)
      assert status == Core.get_status!(status.id)
    end

    test "delete_status/1 deletes the status" do
      status = status_fixture()
      assert {:ok, %Status{}} = Core.delete_status(status)
      assert_raise Ecto.NoResultsError, fn -> Core.get_status!(status.id) end
    end

    test "change_status/1 returns a status changeset" do
      status = status_fixture()
      assert %Ecto.Changeset{} = Core.change_status(status)
    end
  end
end

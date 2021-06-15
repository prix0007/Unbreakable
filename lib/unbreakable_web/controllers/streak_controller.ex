defmodule UnbreakableWeb.StreakController do
  use UnbreakableWeb, :controller

  alias Unbreakable.Core
  alias Unbreakable.Core.Streak

  def index(conn, _params) do
    streaks = Core.list_streaks()
    render(conn, "index.html", streaks: streaks)
  end

  def new(conn, _params) do
    changeset = Core.change_streak(%Streak{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"streak" => streak_params}) do
    case Core.create_streak(streak_params) do
      {:ok, streak} ->
        conn
        |> put_flash(:info, "Streak created successfully.")
        |> redirect(to: Routes.streak_path(conn, :show, streak))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    streak = Core.get_streak!(id)
    render(conn, "show.html", streak: streak)
  end

  def edit(conn, %{"id" => id}) do
    streak = Core.get_streak!(id)
    changeset = Core.change_streak(streak)
    render(conn, "edit.html", streak: streak, changeset: changeset)
  end

  def update(conn, %{"id" => id, "streak" => streak_params}) do
    streak = Core.get_streak!(id)

    case Core.update_streak(streak, streak_params) do
      {:ok, streak} ->
        conn
        |> put_flash(:info, "Streak updated successfully.")
        |> redirect(to: Routes.streak_path(conn, :show, streak))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", streak: streak, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    streak = Core.get_streak!(id)
    {:ok, _streak} = Core.delete_streak(streak)

    conn
    |> put_flash(:info, "Streak deleted successfully.")
    |> redirect(to: Routes.streak_path(conn, :index))
  end
end

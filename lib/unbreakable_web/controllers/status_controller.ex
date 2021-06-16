defmodule UnbreakableWeb.StatusController do
  use UnbreakableWeb, :controller

  alias Unbreakable.Core
  alias Unbreakable.Core.Status

  def index(conn, _params) do
    statuses = Core.list_statuses()
    render(conn, "index.html", statuses: statuses)
  end

  def new(conn, _params) do

    changeset = Core.change_status(%Status{date: Date.utc_today()})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"status" => status_params}) do
    case Core.create_status(status_params) do
      {:ok, status} ->
        today = Date.utc_today()
        case status do
          %{date: ^today, is_complete: true} -> Core.increment_streak(status)
          %{date: ^today, is_complete: false} -> Core.reset_streak(status)
          _ -> nil
        end
        conn
        |> put_flash(:info, "Status created successfully.")
        |> redirect(to: Routes.status_path(conn, :show, status))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    status = Core.get_status!(id)
    render(conn, "show.html", status: status)
  end

  def edit(conn, %{"id" => id}) do
    status = Core.get_status!(id)
    changeset = Core.change_status(status)
    render(conn, "edit.html", status: status, changeset: changeset)
  end

  def update(conn, %{"id" => id, "status" => status_params}) do
    status = Core.get_status!(id)

    case Core.update_status(status, status_params) do
      {:ok, status} ->
        today = Date.utc_today()
        case status do
          %{date: ^today, is_complete: true} -> Core.increment_streak(status)
          %{date: ^today, is_complete: false} -> Core.reset_streak(status)
          _ -> nil
        end
        conn
        |> put_flash(:info, "Status updated successfully.")
        |> redirect(to: Routes.status_path(conn, :show, status))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", status: status, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    status = Core.get_status!(id)
    {:ok, _status} = Core.delete_status(status)

    conn
    |> put_flash(:info, "Status deleted successfully.")
    |> redirect(to: Routes.status_path(conn, :index))
  end
end

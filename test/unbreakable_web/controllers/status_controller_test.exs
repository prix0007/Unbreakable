defmodule UnbreakableWeb.StatusControllerTest do
  use UnbreakableWeb.ConnCase

  alias Unbreakable.Core

  @create_attrs %{date: ~D[2010-04-17], is_complete: true}
  @update_attrs %{date: ~D[2011-05-18], is_complete: false}
  @invalid_attrs %{date: nil, is_complete: nil}

  def fixture(:status) do
    {:ok, status} = Core.create_status(@create_attrs)
    status
  end

  describe "index" do
    test "lists all statuses", %{conn: conn} do
      conn = get(conn, Routes.status_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Statuses"
    end
  end

  describe "new status" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.status_path(conn, :new))
      assert html_response(conn, 200) =~ "New Status"
    end
  end

  describe "create status" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.status_path(conn, :create), status: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.status_path(conn, :show, id)

      conn = get(conn, Routes.status_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Status"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.status_path(conn, :create), status: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Status"
    end
  end

  describe "edit status" do
    setup [:create_status]

    test "renders form for editing chosen status", %{conn: conn, status: status} do
      conn = get(conn, Routes.status_path(conn, :edit, status))
      assert html_response(conn, 200) =~ "Edit Status"
    end
  end

  describe "update status" do
    setup [:create_status]

    test "redirects when data is valid", %{conn: conn, status: status} do
      conn = put(conn, Routes.status_path(conn, :update, status), status: @update_attrs)
      assert redirected_to(conn) == Routes.status_path(conn, :show, status)

      conn = get(conn, Routes.status_path(conn, :show, status))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, status: status} do
      conn = put(conn, Routes.status_path(conn, :update, status), status: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Status"
    end
  end

  describe "delete status" do
    setup [:create_status]

    test "deletes chosen status", %{conn: conn, status: status} do
      conn = delete(conn, Routes.status_path(conn, :delete, status))
      assert redirected_to(conn) == Routes.status_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.status_path(conn, :show, status))
      end
    end
  end

  defp create_status(_) do
    status = fixture(:status)
    %{status: status}
  end
end

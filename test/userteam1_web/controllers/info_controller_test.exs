defmodule Userteam1Web.InfoControllerTest do
  use Userteam1Web.ConnCase

  alias Userteam1.Web

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  def fixture(:info) do
    {:ok, info} = Web.create_info(@create_attrs)
    info
  end

  describe "index" do
    test "lists all infos", %{conn: conn} do
      conn = get conn, info_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Infos"
    end
  end

  describe "new info" do
    test "renders form", %{conn: conn} do
      conn = get conn, info_path(conn, :new)
      assert html_response(conn, 200) =~ "New Info"
    end
  end

  describe "create info" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, info_path(conn, :create), info: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == info_path(conn, :show, id)

      conn = get conn, info_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Info"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, info_path(conn, :create), info: @invalid_attrs
      assert html_response(conn, 200) =~ "New Info"
    end
  end

  describe "edit info" do
    setup [:create_info]

    test "renders form for editing chosen info", %{conn: conn, info: info} do
      conn = get conn, info_path(conn, :edit, info)
      assert html_response(conn, 200) =~ "Edit Info"
    end
  end

  describe "update info" do
    setup [:create_info]

    test "redirects when data is valid", %{conn: conn, info: info} do
      conn = put conn, info_path(conn, :update, info), info: @update_attrs
      assert redirected_to(conn) == info_path(conn, :show, info)

      conn = get conn, info_path(conn, :show, info)
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, info: info} do
      conn = put conn, info_path(conn, :update, info), info: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Info"
    end
  end

  describe "delete info" do
    setup [:create_info]

    test "deletes chosen info", %{conn: conn, info: info} do
      conn = delete conn, info_path(conn, :delete, info)
      assert redirected_to(conn) == info_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, info_path(conn, :show, info)
      end
    end
  end

  defp create_info(_) do
    info = fixture(:info)
    {:ok, info: info}
  end
end

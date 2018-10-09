defmodule Userteam1Web.ChallengeGroupControllerTest do
  use Userteam1Web.ConnCase

  alias Userteam1.Web

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:challenge_group) do
    {:ok, challenge_group} = Web.create_challenge_group(@create_attrs)
    challenge_group
  end

  describe "index" do
    test "lists all challengegroups", %{conn: conn} do
      conn = get conn, challenge_group_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Challengegroups"
    end
  end

  describe "new challenge_group" do
    test "renders form", %{conn: conn} do
      conn = get conn, challenge_group_path(conn, :new)
      assert html_response(conn, 200) =~ "New Challenge group"
    end
  end

  describe "create challenge_group" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, challenge_group_path(conn, :create), challenge_group: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == challenge_group_path(conn, :show, id)

      conn = get conn, challenge_group_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Challenge group"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, challenge_group_path(conn, :create), challenge_group: @invalid_attrs
      assert html_response(conn, 200) =~ "New Challenge group"
    end
  end

  describe "edit challenge_group" do
    setup [:create_challenge_group]

    test "renders form for editing chosen challenge_group", %{conn: conn, challenge_group: challenge_group} do
      conn = get conn, challenge_group_path(conn, :edit, challenge_group)
      assert html_response(conn, 200) =~ "Edit Challenge group"
    end
  end

  describe "update challenge_group" do
    setup [:create_challenge_group]

    test "redirects when data is valid", %{conn: conn, challenge_group: challenge_group} do
      conn = put conn, challenge_group_path(conn, :update, challenge_group), challenge_group: @update_attrs
      assert redirected_to(conn) == challenge_group_path(conn, :show, challenge_group)

      conn = get conn, challenge_group_path(conn, :show, challenge_group)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, challenge_group: challenge_group} do
      conn = put conn, challenge_group_path(conn, :update, challenge_group), challenge_group: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Challenge group"
    end
  end

  describe "delete challenge_group" do
    setup [:create_challenge_group]

    test "deletes chosen challenge_group", %{conn: conn, challenge_group: challenge_group} do
      conn = delete conn, challenge_group_path(conn, :delete, challenge_group)
      assert redirected_to(conn) == challenge_group_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, challenge_group_path(conn, :show, challenge_group)
      end
    end
  end

  defp create_challenge_group(_) do
    challenge_group = fixture(:challenge_group)
    {:ok, challenge_group: challenge_group}
  end
end

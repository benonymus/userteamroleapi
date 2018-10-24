defmodule Userteam1Web.ChallengeControllerTest do
  use Userteam1Web.ConnCase

  alias Userteam1.Web

  @create_attrs %{description: "some description", difficulty: 42, name: "some name"}
  @update_attrs %{description: "some updated description", difficulty: 43, name: "some updated name"}
  @invalid_attrs %{description: nil, difficulty: nil, name: nil}

  def fixture(:challenge) do
    {:ok, challenge} = Web.create_challenge(@create_attrs)
    challenge
  end

  describe "index" do
    test "lists all challenges", %{conn: conn} do
      conn = get conn, challenge_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Challenges"
    end
  end

  describe "new challenge" do
    test "renders form", %{conn: conn} do
      conn = get conn, challenge_path(conn, :new)
      assert html_response(conn, 200) =~ "New Challenge"
    end
  end

  describe "create challenge" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, challenge_path(conn, :create), challenge: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == challenge_path(conn, :show, id)

      conn = get conn, challenge_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Challenge"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, challenge_path(conn, :create), challenge: @invalid_attrs
      assert html_response(conn, 200) =~ "New Challenge"
    end
  end

  describe "edit challenge" do
    setup [:create_challenge]

    test "renders form for editing chosen challenge", %{conn: conn, challenge: challenge} do
      conn = get conn, challenge_path(conn, :edit, challenge)
      assert html_response(conn, 200) =~ "Edit Challenge"
    end
  end

  describe "update challenge" do
    setup [:create_challenge]

    test "redirects when data is valid", %{conn: conn, challenge: challenge} do
      conn = put conn, challenge_path(conn, :update, challenge), challenge: @update_attrs
      assert redirected_to(conn) == challenge_path(conn, :show, challenge)

      conn = get conn, challenge_path(conn, :show, challenge)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, challenge: challenge} do
      conn = put conn, challenge_path(conn, :update, challenge), challenge: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Challenge"
    end
  end

  describe "delete challenge" do
    setup [:create_challenge]

    test "deletes chosen challenge", %{conn: conn, challenge: challenge} do
      conn = delete conn, challenge_path(conn, :delete, challenge)
      assert redirected_to(conn) == challenge_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, challenge_path(conn, :show, challenge)
      end
    end
  end

  defp create_challenge(_) do
    challenge = fixture(:challenge)
    {:ok, challenge: challenge}
  end
end

defmodule Userteam1Web.RecordingControllerTest do
  use Userteam1Web.ConnCase

  alias Userteam1.Web
  alias Userteam1.Web.Recording

  @create_attrs %{path_to_recording: "some path_to_recording"}
  @update_attrs %{path_to_recording: "some updated path_to_recording"}
  @invalid_attrs %{path_to_recording: nil}

  def fixture(:recording) do
    {:ok, recording} = Web.create_recording(@create_attrs)
    recording
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all recordings", %{conn: conn} do
      conn = get conn, recording_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create recording" do
    test "renders recording when data is valid", %{conn: conn} do
      conn = post conn, recording_path(conn, :create), recording: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, recording_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "path_to_recording" => "some path_to_recording"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, recording_path(conn, :create), recording: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update recording" do
    setup [:create_recording]

    test "renders recording when data is valid", %{conn: conn, recording: %Recording{id: id} = recording} do
      conn = put conn, recording_path(conn, :update, recording), recording: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, recording_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "path_to_recording" => "some updated path_to_recording"}
    end

    test "renders errors when data is invalid", %{conn: conn, recording: recording} do
      conn = put conn, recording_path(conn, :update, recording), recording: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete recording" do
    setup [:create_recording]

    test "deletes chosen recording", %{conn: conn, recording: recording} do
      conn = delete conn, recording_path(conn, :delete, recording)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, recording_path(conn, :show, recording)
      end
    end
  end

  defp create_recording(_) do
    recording = fixture(:recording)
    {:ok, recording: recording}
  end
end

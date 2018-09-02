defmodule Userteam1Web.RecordingController do
  use Userteam1Web, :controller
  import Ecto.Query

  alias Userteam1.Repo
  alias Userteam1.Web
  alias Userteam1.Web.Recording

  def get_recording_list(user) do
    recording_query =
      from(
        r in Recording,
        preload: [:user],
        where: r.user_id == ^user.id,
        select: r
      )

    Repo.all(recording_query)
  end

  def index(conn, _params) do
    recordings = Web.list_recordings()
    render(conn, "index.json", recordings: recordings)
  end

  def create(conn, %{"recording" => recording_params}) do
    with {:ok, %Recording{} = recording} <- Web.create_recording(recording_params) do
      conn
      |> render("show.json", recording: recording)
    end
  end

  def show(conn, %{"id" => id}) do
    recording = Web.get_recording!(id)
    render(conn, "show.json", recording: recording)
  end

  def update(conn, %{"id" => id, "recording" => recording_params}) do
    recording = Web.get_recording!(id)

    with {:ok, %Recording{} = recording} <- Web.update_recording(recording, recording_params) do
      render(conn, "show.json", recording: recording)
    end
  end

  def delete(conn, %{"id" => id}) do
    recording = Web.get_recording!(id)

    with {:ok, %Recording{}} <- Web.delete_recording(recording) do
      send_resp(conn, :no_content, "")
    end
  end
end

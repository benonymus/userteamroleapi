defmodule Userteam1Web.RecordingView do
  use Userteam1Web, :view
  alias Userteam1Web.RecordingView

  def render("index.json", %{recordings: recordings}) do
    %{data: render_many(recordings, RecordingView, "recording.json")}
  end

  def render("show.json", %{recording: recording}) do
    %{data: render_one(recording, RecordingView, "recording.json")}
  end

  def render("recording.json", %{recording: recording}) do
    %{id: recording.id,
      path_to_recording: recording.path_to_recording}
  end
end

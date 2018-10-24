defmodule Userteam1Web.RecordingView do
  use Userteam1Web, :view

  alias Userteam1Web.RecordingView
  alias Userteam1Web.CommentView

  def render("index.json", %{recordings: recordings}) do
    %{data: render_many(recordings, RecordingView, "recording_mod.json")}
  end

  def render("show.json", %{recording: recording}) do
    %{data: render_one(recording, RecordingView, "recording_mod.json")}
  end

  def render("recording_mod.json", %{recording: recording}) do
    %{
      id: recording.id,
      recording_name: recording.name,
      recording_type: recording.type,
      path_to_recording: render_recording_url(recording)
    }
  end

  def render("recording.json", %{recording: recording}) do
    %{
      id: recording.id,
      user_id: recording.user_id,
      recording_name: recording.name,
      recording_type: recording.type,
      path_to_recording: render_recording_url(recording),
      recording_comments:
        if recording.comment == nil do
          "no comments yet"
        else
          render_many(recording.comment, CommentView, "comment.json")
        end,
      number_of_comments: length(recording.comment)
    }
  end

  defp render_recording_url(recording) do
    if recording.path_to_recording != nil do
      Userteam1Web.Recording.url({recording.path_to_recording, recording}, :original)
    else
      nil
    end
  end
end

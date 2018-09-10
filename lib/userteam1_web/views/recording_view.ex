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
      path_to_recording: recording.path_to_recording,
      mod_score: recording.mod_score
    }
  end

  def render("recording.json", %{recording: recording}) do
    %{
      id: recording.id,
      path_to_recording: recording.path_to_recording,
      recording_comments:
        if recording.comment == nil do
          "no comments yet"
        else
          render_many(recording.comment, CommentView, "comment.json")
        end
    }
  end
end
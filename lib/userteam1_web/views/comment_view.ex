defmodule Userteam1Web.CommentView do
  use Userteam1Web, :view
  alias Userteam1Web.CommentView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{
      id: comment.id,
      message: comment.message,
      user_name: comment.user.name,
      avatar: comment.user.avatar
    }
  end
end

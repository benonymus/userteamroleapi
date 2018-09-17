defmodule Userteam1Web.CommentController do
  use Userteam1Web, :controller

  alias Userteam1.Web
  alias Userteam1.Web.Comment

  action_fallback(Userteam1Web.FallbackController)

  def index(conn, _params) do
    comments = Web.list_comments()
    render(conn, "index.json", comments: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    with {:ok, %Comment{} = comment} <- Web.create_comment(comment_params) do
      # conn
      # |> put_status(:created)
      # |> render("show.json", comment: comment)
      send_resp(conn, 200, [])
    end
  end

  def show(conn, %{"id" => id}) do
    comment = Web.get_comment!(id)
    render(conn, "show.json", comment: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Web.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Web.update_comment(comment, comment_params) do
      render(conn, "show.json", comment: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Web.get_comment!(id)

    with {:ok, %Comment{}} <- Web.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end

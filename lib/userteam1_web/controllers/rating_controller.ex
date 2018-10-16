defmodule Userteam1Web.RatingController do
  use Userteam1Web, :controller

  alias Userteam1.Web
  alias Userteam1.Web.Rating

  action_fallback(Userteam1Web.FallbackController)

  def index(conn, _params) do
    ratings = Web.list_ratings()
    render(conn, "index.json", ratings: ratings)
  end

  def create(conn, %{"rating" => rating_params}) do
    with {:ok, %Rating{} = _rating} <- Web.create_rating(rating_params) do
      # conn
      # |> put_status(:created)
      # |> put_resp_header("location", rating_path(conn, :show, rating))
      # |> render("show.json", rating: rating)
      send_resp(conn, 200, [])
    end
  end

  def show(conn, %{"id" => id}) do
    rating = Web.get_rating!(id)
    render(conn, "show.json", rating: rating)
  end

  def update(conn, %{"id" => id, "rating" => rating_params}) do
    rating = Web.get_rating!(id)

    with {:ok, %Rating{} = rating} <- Web.update_rating(rating, rating_params) do
      render(conn, "show.json", rating: rating)
    end
  end

  def delete(conn, %{"id" => id}) do
    rating = Web.get_rating!(id)

    with {:ok, %Rating{}} <- Web.delete_rating(rating) do
      send_resp(conn, :no_content, "")
    end
  end
end

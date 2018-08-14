defmodule Userteam1Web.PageController do
  use Userteam1Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

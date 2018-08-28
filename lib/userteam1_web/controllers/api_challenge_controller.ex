defmodule Userteam1Web.ApiChallengeController do
  use Userteam1Web, :controller
  alias Userteam1.Web

  def index(conn, _params) do
    challenges = Web.list_challenges()
    render(conn, "index.json", challenges: challenges)
  end
end

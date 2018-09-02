defmodule Userteam1Web.ApiChallengeController do
  use Userteam1Web, :controller
  alias Userteam1.Web

  def index(conn, _params) do
    challenges = Web.list_challenges()
    render(conn, "index.json", challenges: challenges)
  end

  # to use for gwtting the %
  # def show(conn, %{"id" => id}) do
  #   user = Guardian.Plug.current_resource(conn)
  #   challenge = Web.get_challenge!(id)
  #   recording_list = Userteam1Web.RecordingController.get_recording_list(user)
  #   IO.puts("list here")
  #   IO.inspect(recording_list)
  #   render(conn, "challenge.json", challenge: challenge)
  # end
end

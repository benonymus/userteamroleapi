defmodule Userteam1Web.ApiInfoController do
  use Userteam1Web, :controller

  alias Userteam1.Web

  def show(conn, _params) do
    infos = Web.list_infos()
    info = List.first(infos)
    render(conn, "info.json", info: info)
  end
end

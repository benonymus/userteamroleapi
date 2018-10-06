defmodule Userteam1Web.TeamController do
  use Userteam1Web, :controller

  alias Userteam1.Web
  alias Userteam1.Web.Team

  def index(conn, _params) do
    teams = Web.list_teams()
    render(conn, "index.html", teams: teams)
  end

  def new(conn, _params) do
    changeset = Web.change_team(%Team{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"team" => team_params}) do
    case Web.create_team(team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team created successfully.")
        |> redirect(to: team_path(conn, :show, team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Web.get_team!(id)
    render(conn, "show.html", team: team)
  end

  def edit(conn, %{"id" => id}) do
    team = Web.get_team!(id)
    changeset = Web.change_team(team)
    render(conn, "edit.html", team: team, changeset: changeset)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Web.get_team!(id)

    case Web.update_team(team, team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team updated successfully.")
        |> redirect(to: team_path(conn, :show, team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", team: team, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Web.get_team!(id)

    case Web.delete_team(team) do
      {:ok, _team} ->
        IO.puts("succ")

        conn
        |> put_flash(:info, "Team deleted successfully.")
        |> redirect(to: team_path(conn, :index))

      {:error, %Ecto.Changeset{} = _changeset} ->
        IO.puts("SHIT")
        # render(conn, "edit.html", team: team, changeset: changeset)
    end

    # {:ok, _team} = Web.delete_team(team)
    #
    # conn
    # |> put_flash(:info, "Team deleted successfully.")
    # |> redirect(to: team_path(conn, :index))
  end
end

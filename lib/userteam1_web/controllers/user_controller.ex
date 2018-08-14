defmodule Userteam1Web.UserController do
  use Userteam1Web, :controller
  alias Userteam1.Repo

  alias Userteam1.Web
  alias Userteam1.Web.User

  def index(conn, _params) do
    users = Web.list_users()
    IO.inspect(users)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    teams =
      Repo.all(Userteam1.Team)
      |> Enum.map(&{&1.name, &1.id})

    roles =
      Repo.all(Userteam1.Role)
      |> Enum.map(&{&1.name, &1.id})

    changeset = Web.change_user(%User{})
    render(conn, "new.html", changeset: changeset, teams: teams, roles: roles)
  end

  def create(conn, %{"user" => user_params}) do
    IO.inspect(user_params)

    case Web.create_user(user_params) do
      {:ok, user} ->
        IO.inspect(user)

        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.puts("shit")
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Web.get_user!(id)
    IO.inspect(user)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    teams =
      Repo.all(Userteam1.Team)
      |> Enum.map(&{&1.name, &1.id})

    roles =
      Repo.all(Userteam1.Role)
      |> Enum.map(&{&1.name, &1.id})

    user = Web.get_user!(id)
    changeset = Web.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset, teams: teams, roles: roles)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Web.get_user!(id)

    case Web.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Web.get_user!(id)
    {:ok, _user} = Web.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end

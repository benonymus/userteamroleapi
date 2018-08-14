defmodule Userteam1Web.RoleController do
  use Userteam1Web, :controller

  alias Userteam1.Web
  alias Userteam1.Web.Role

  def index(conn, _params) do
    roles = Web.list_roles()
    render(conn, "index.html", roles: roles)
  end

  def new(conn, _params) do
    changeset = Web.change_role(%Role{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"role" => role_params}) do
    case Web.create_role(role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role created successfully.")
        |> redirect(to: role_path(conn, :show, role))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Web.get_role!(id)
    render(conn, "show.html", role: role)
  end

  def edit(conn, %{"id" => id}) do
    role = Web.get_role!(id)
    changeset = Web.change_role(role)
    render(conn, "edit.html", role: role, changeset: changeset)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Web.get_role!(id)

    case Web.update_role(role, role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role updated successfully.")
        |> redirect(to: role_path(conn, :show, role))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", role: role, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Web.get_role!(id)
    {:ok, _role} = Web.delete_role(role)

    conn
    |> put_flash(:info, "Role deleted successfully.")
    |> redirect(to: role_path(conn, :index))
  end
end

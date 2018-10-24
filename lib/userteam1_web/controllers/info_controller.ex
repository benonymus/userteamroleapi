defmodule Userteam1Web.InfoController do
  use Userteam1Web, :controller

  alias Userteam1.Web
  alias Userteam1.Web.Info

  def index(conn, _params) do
    infos = Web.list_infos()
    render(conn, "index.html", infos: infos)
  end

  def new(conn, _params) do
    changeset = Web.change_info(%Info{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"info" => info_params}) do
    case Web.create_info(info_params) do
      {:ok, info} ->
        conn
        |> put_flash(:info, "Info created successfully.")
        |> redirect(to: info_path(conn, :show, info))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    info = Web.get_info!(id)
    render(conn, "show.html", info: info)
  end

  def edit(conn, %{"id" => id}) do
    info = Web.get_info!(id)
    changeset = Web.change_info(info)
    render(conn, "edit.html", info: info, changeset: changeset)
  end

  def update(conn, %{"id" => id, "info" => info_params}) do
    info = Web.get_info!(id)

    case Web.update_info(info, info_params) do
      {:ok, info} ->
        conn
        |> put_flash(:info, "Info updated successfully.")
        |> redirect(to: info_path(conn, :show, info))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", info: info, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    info = Web.get_info!(id)
    {:ok, _info} = Web.delete_info(info)

    conn
    |> put_flash(:info, "Info deleted successfully.")
    |> redirect(to: info_path(conn, :index))
  end
end

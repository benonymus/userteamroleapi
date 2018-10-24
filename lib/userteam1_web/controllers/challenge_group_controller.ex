defmodule Userteam1Web.ChallengeGroupController do
  use Userteam1Web, :controller

  alias Userteam1.Web
  alias Userteam1.Web.ChallengeGroup

  def index(conn, _params) do
    challengegroups = Web.list_challengegroups()
    render(conn, "index.html", challengegroups: challengegroups)
  end

  def new(conn, _params) do
    changeset = Web.change_challenge_group(%ChallengeGroup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"challenge_group" => challenge_group_params}) do
    case Web.create_challenge_group(challenge_group_params) do
      {:ok, challenge_group} ->
        conn
        |> put_flash(:info, "Challenge group created successfully.")
        |> redirect(to: challenge_group_path(conn, :show, challenge_group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    challenge_group = Web.get_challenge_group!(id)
    render(conn, "show.html", challenge_group: challenge_group)
  end

  def edit(conn, %{"id" => id}) do
    challenge_group = Web.get_challenge_group!(id)
    changeset = Web.change_challenge_group(challenge_group)
    render(conn, "edit.html", challenge_group: challenge_group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "challenge_group" => challenge_group_params}) do
    challenge_group = Web.get_challenge_group!(id)

    case Web.update_challenge_group(challenge_group, challenge_group_params) do
      {:ok, challenge_group} ->
        conn
        |> put_flash(:info, "Challenge group updated successfully.")
        |> redirect(to: challenge_group_path(conn, :show, challenge_group))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", challenge_group: challenge_group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    challenge_group = Web.get_challenge_group!(id)

    if challenge_group.avatar do
      {:ok, path} = Userteam1Web.ChallengeGroupAvatar.store(challenge_group.avatar)
      :ok = Userteam1Web.ChallengeGroupAvatar.delete(path)
    end

    {:ok, _challenge_group} = Web.delete_challenge_group(challenge_group)

    conn
    |> put_flash(:info, "Challenge group deleted successfully.")
    |> redirect(to: challenge_group_path(conn, :index))
  end
end

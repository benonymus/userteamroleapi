defmodule Userteam1Web.ChallengeController do
  use Userteam1Web, :controller
  import Ecto.Query

  alias Userteam1.Repo
  alias Userteam1.Web
  alias Userteam1.Web.Challenge

  def index(conn, _params) do
    challenges = Web.list_challenges()
    render(conn, "index.html", challenges: challenges)
  end

  def new(conn, _params) do
    challenge_groups =
      Repo.all(Userteam1.Web.ChallengeGroup)
      |> Enum.map(&{&1.name, &1.id})

    challenge_groups = [{"", ""} | challenge_groups]

    changeset = Web.change_challenge(%Challenge{})
    render(conn, "new.html", changeset: changeset, challenge_groups: challenge_groups)
  end

  def create(conn, %{"challenge" => challenge_params}) do
    challenge_groups =
      Repo.all(Userteam1.Web.ChallengeGroup)
      |> Enum.map(&{&1.name, &1.id})

    challenge_groups = [{"", ""} | challenge_groups]

    case Web.create_challenge(challenge_params) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge created successfully.")
        |> redirect(to: challenge_path(conn, :show, challenge))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, challenge_groups: challenge_groups)
    end
  end

  def show(conn, %{"id" => id}) do
    challenge = Web.get_challenge!(id)
    render(conn, "show.html", challenge: challenge)
  end

  def edit(conn, %{"id" => id}) do
    challenge = Web.get_challenge!(id)
    changeset = Web.change_challenge(challenge)

    challenge_groups =
      Repo.all(Userteam1.Web.ChallengeGroup)
      |> Enum.map(&{&1.name, &1.id})

    challenge_groups = [{"", ""} | challenge_groups]

    render(conn, "edit.html",
      challenge: challenge,
      changeset: changeset,
      challenge_groups: challenge_groups
    )
  end

  def update(conn, %{"id" => id, "challenge" => challenge_params}) do
    challenge = Web.get_challenge!(id)

    challenge_groups =
      Repo.all(Userteam1.Web.ChallengeGroup)
      |> Enum.map(&{&1.name, &1.id})

    challenge_groups = [{"", ""} | challenge_groups]

    case Web.update_challenge(challenge, challenge_params) do
      {:ok, challenge} ->
        conn
        |> put_flash(:info, "Challenge updated successfully.")
        |> redirect(to: challenge_path(conn, :show, challenge))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
          challenge: challenge,
          changeset: changeset,
          challenge_groups: challenge_groups
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    challenge = Web.get_challenge!(id)
    {:ok, _challenge} = Web.delete_challenge(challenge)

    conn
    |> put_flash(:info, "Challenge deleted successfully.")
    |> redirect(to: challenge_path(conn, :index))
  end
end

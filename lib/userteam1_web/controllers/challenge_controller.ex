defmodule Userteam1Web.ChallengeController do
  use Userteam1Web, :controller
  import Ecto.Query

  alias Userteam1.Repo
  alias Userteam1.Web
  alias Userteam1.Web.Challenge

  defp get_challenge_by_challenge_group(challenge_group_id) do
    challenge_query =
      from(
        c in Challenge,
        where: c.challenge_group_id == ^challenge_group_id and c.main == true,
        select: c
      )

    Repo.all(challenge_query)
  end

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

    check_by_challenge_group =
      if challenge_params["challenge_group_id"] != "" do
        get_challenge_by_challenge_group(challenge_params["challenge_group_id"])
      else
        []
      end

    if challenge_params["main"] == "true" do
      if length(check_by_challenge_group) > 0 do
        changeset = Challenge.changeset(%Challenge{}, challenge_params)

        conn
        |> put_flash(:error, "There is a main Challenge for this Challenge Group already!")
        |> render("new.html", changeset: changeset, challenge_groups: challenge_groups)
      else
        case Web.create_challenge(challenge_params) do
          {:ok, challenge} ->
            conn
            |> put_flash(:info, "Challenge created successfully.")
            |> redirect(to: challenge_path(conn, :show, challenge))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset, challenge_groups: challenge_groups)
        end
      end
    else
      if challenge_params["challenge_group_id"] == "" do
        challenge_params = Map.put(challenge_params, "main", true)

        case Web.create_challenge(challenge_params) do
          {:ok, challenge} ->
            conn
            |> put_flash(:info, "Challenge created successfully.")
            |> redirect(to: challenge_path(conn, :show, challenge))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset, challenge_groups: challenge_groups)
        end
      else
        case Web.create_challenge(challenge_params) do
          {:ok, challenge} ->
            conn
            |> put_flash(:info, "Challenge created successfully.")
            |> redirect(to: challenge_path(conn, :show, challenge))

          {:error, %Ecto.Changeset{} = changeset} ->
            render(conn, "new.html", changeset: changeset, challenge_groups: challenge_groups)
        end
      end
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
    changeset = Web.change_challenge(challenge)

    challenge_groups =
      Repo.all(Userteam1.Web.ChallengeGroup)
      |> Enum.map(&{&1.name, &1.id})

    challenge_groups = [{"", ""} | challenge_groups]

    check_by_challenge_group =
      if challenge_params["challenge_group_id"] != "" do
        get_challenge_by_challenge_group(challenge_params["challenge_group_id"])
      end

    if challenge_params["main"] == "true" do
      if length(check_by_challenge_group) > 0 do
        conn
        |> put_flash(:error, "There is a main Challenge for this Challenge Group already!")
        |> render("edit.html",
          challenge: challenge,
          changeset: changeset,
          challenge_groups: challenge_groups
        )
      else
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
    else
      if challenge_params["challenge_group_id"] == "" do
        challenge_params = Map.put(challenge_params, "main", true)

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
      else
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

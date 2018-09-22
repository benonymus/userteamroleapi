defmodule Userteam1Web.RecordingController do
  use Userteam1Web, :controller
  import Ecto.Query

  alias Userteam1.Repo
  alias Userteam1.Web
  alias Userteam1.Web.Recording
  alias Userteam1Web.ApiTeamController
  alias Userteam1.Web.Comment

  action_fallback(Userteam1Web.FallbackController)

  def get_recording_list(user) do
    comment_order_query = from(c in Comment, order_by: c.inserted_at, preload: [:user])

    recording_query =
      from(
        r in Recording,
        order_by: [desc: r.id],
        where: r.user_id == ^user.id,
        preload: [:user, comment: ^comment_order_query],
        select: r
      )

    Repo.all(recording_query)
  end

  def get_recording_list_by_user_id_and_challenge_id(user_id, challenge_id) do
    recording_query =
      from(
        r in Recording,
        where: r.user_id == ^user_id and r.challenge_id == ^challenge_id,
        select: r
      )

    Repo.all(recording_query)
  end

  def get_recording_list_by_team_members(team_members) do
    team_members_ids = Enum.map(team_members, fn team_member -> team_member.id end)
    comment_order_query = from(c in Comment, order_by: c.inserted_at, preload: [:user])

    recording_query =
      from(
        r in Recording,
        order_by: [desc: r.id],
        where: r.user_id in ^team_members_ids,
        preload: [:user, comment: ^comment_order_query],
        select: r
      )

    Repo.all(recording_query)
  end

  def get_recording_list_by_team_members_and_challeneg_id(team_members, challenge_id) do
    team_members_ids = Enum.map(team_members, fn team_member -> team_member.id end)

    recording_query =
      from(
        r in Recording,
        order_by: [desc: r.id],
        where: r.user_id in ^team_members_ids and r.challenge_id == ^challenge_id,
        preload: [:user],
        select: r
      )

    Repo.all(recording_query)
  end

  def get_recording_list_for_mod(team_members) do
    team_members_ids = Enum.map(team_members, fn team_member -> team_member.id end)
    comment_order_query = from(c in Comment, order_by: c.inserted_at, preload: [:user])

    recording_query =
      from(
        r in Recording,
        where: r.user_id in ^team_members_ids and is_nil(r.mod_score),
        preload: [comment: ^comment_order_query],
        select: r
      )

    Repo.all(recording_query)
  end

  def get_recording_list_scored(user) do
    comment_order_query = from(c in Comment, order_by: c.inserted_at, preload: [:user])

    recording_query =
      from(
        r in Recording,
        order_by: [desc: r.id],
        where: r.user_id == ^user.id and not is_nil(r.mod_score),
        preload: [:user, comment: ^comment_order_query],
        select: r
      )

    Repo.all(recording_query)
  end

  def get_mod_score_sum(user) do
    score_query =
      from(
        r in Recording,
        where: r.user_id == ^user.id,
        select: sum(r.mod_score)
      )

    Repo.all(score_query)
  end

  def index(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    team = Web.get_team!(user.team.id)
    team_members = ApiTeamController.get_team_members(team)
    recordings = get_recording_list_for_mod(team_members)
    render(conn, "index.json", recordings: recordings)
  end

  def create(conn, %{"recording" => recording_params}) do
    IO.puts(recording_params)

    recordings =
      get_recording_list_by_user_id_and_challenge_id(
        recording_params.user_id,
        recording_params.challenge_id
      )

    if recordings == nil || length(recordings) < 1 do
      with {:ok, %Recording{} = recording} <- Web.create_recording(recording_params) do
        challenge = Web.get_challenge!(recording.challenge_id)
        number_of_days_between = Date.diff(challenge.due_date, recording.inserted_at)
        calculated_score = number_of_days_between * challenge.difficulty * 100
        user = Web.get_user!(recording.user_id)
        score_to_insert = user.score + calculated_score

        updated_user = %{
          score: score_to_insert
        }

        Web.update_user(user, updated_user)
        send_resp(conn, 200, [])
      end
    else
      # if there was any number of recordings delete them and then add the new one without effecting the score
      for recording <- recordings do
        Web.delete_recording(recording)
      end

      with {:ok, %Recording{}} <- Web.create_recording(recording_params) do
        send_resp(conn, 200, [])
      end
    end
  end

  def show(conn, %{"id" => id}) do
    recording = Web.get_recording!(id)
    render(conn, "show.json", recording: recording)
  end

  def update(conn, %{"id" => id, "recording" => recording_params}) do
    recording = Web.get_recording!(id)

    with {:ok, %Recording{} = recording} <- Web.update_recording(recording, recording_params) do
      render(conn, "show.json", recording: recording)
    end
  end

  def delete(conn, %{"id" => id}) do
    recording = Web.get_recording!(id)

    with {:ok, %Recording{}} <- Web.delete_recording(recording) do
      send_resp(conn, :no_content, "")
    end
  end
end

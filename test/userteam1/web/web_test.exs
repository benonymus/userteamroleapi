defmodule Userteam1.WebTest do
  use Userteam1.DataCase

  alias Userteam1.Web

  describe "users" do
    alias Userteam1.Web.User

    @valid_attrs %{name: "some name", password: "some password"}
    @update_attrs %{name: "some updated name", password: "some updated password"}
    @invalid_attrs %{name: nil, password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Web.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Web.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Web.create_user(@valid_attrs)
      assert user.name == "some name"
      assert user.password == "some password"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Web.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.name == "some updated name"
      assert user.password == "some updated password"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_user(user, @invalid_attrs)
      assert user == Web.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Web.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Web.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Web.change_user(user)
    end
  end

  describe "teams" do
    alias Userteam1.Web.Team

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def team_fixture(attrs \\ %{}) do
      {:ok, team} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_team()

      team
    end

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Web.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Web.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      assert {:ok, %Team{} = team} = Web.create_team(@valid_attrs)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      assert {:ok, team} = Web.update_team(team, @update_attrs)
      assert %Team{} = team
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_team(team, @invalid_attrs)
      assert team == Web.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Web.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Web.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Web.change_team(team)
    end
  end

  describe "roles" do
    alias Userteam1.Web.Role

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def role_fixture(attrs \\ %{}) do
      {:ok, role} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_role()

      role
    end

    test "list_roles/0 returns all roles" do
      role = role_fixture()
      assert Web.list_roles() == [role]
    end

    test "get_role!/1 returns the role with given id" do
      role = role_fixture()
      assert Web.get_role!(role.id) == role
    end

    test "create_role/1 with valid data creates a role" do
      assert {:ok, %Role{} = role} = Web.create_role(@valid_attrs)
      assert role.name == "some name"
    end

    test "create_role/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_role(@invalid_attrs)
    end

    test "update_role/2 with valid data updates the role" do
      role = role_fixture()
      assert {:ok, role} = Web.update_role(role, @update_attrs)
      assert %Role{} = role
      assert role.name == "some updated name"
    end

    test "update_role/2 with invalid data returns error changeset" do
      role = role_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_role(role, @invalid_attrs)
      assert role == Web.get_role!(role.id)
    end

    test "delete_role/1 deletes the role" do
      role = role_fixture()
      assert {:ok, %Role{}} = Web.delete_role(role)
      assert_raise Ecto.NoResultsError, fn -> Web.get_role!(role.id) end
    end

    test "change_role/1 returns a role changeset" do
      role = role_fixture()
      assert %Ecto.Changeset{} = Web.change_role(role)
    end
  end

  describe "challenges" do
    alias Userteam1.Web.Challenge

    @valid_attrs %{description: "some description", difficulty: 42, name: "some name"}
    @update_attrs %{
      description: "some updated description",
      difficulty: 43,
      name: "some updated name"
    }
    @invalid_attrs %{description: nil, difficulty: nil, name: nil}

    def challenge_fixture(attrs \\ %{}) do
      {:ok, challenge} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_challenge()

      challenge
    end

    test "list_challenges/0 returns all challenges" do
      challenge = challenge_fixture()
      assert Web.list_challenges() == [challenge]
    end

    test "get_challenge!/1 returns the challenge with given id" do
      challenge = challenge_fixture()
      assert Web.get_challenge!(challenge.id) == challenge
    end

    test "create_challenge/1 with valid data creates a challenge" do
      assert {:ok, %Challenge{} = challenge} = Web.create_challenge(@valid_attrs)
      assert challenge.description == "some description"
      assert challenge.difficulty == 42
      assert challenge.name == "some name"
    end

    test "create_challenge/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_challenge(@invalid_attrs)
    end

    test "update_challenge/2 with valid data updates the challenge" do
      challenge = challenge_fixture()
      assert {:ok, challenge} = Web.update_challenge(challenge, @update_attrs)
      assert %Challenge{} = challenge
      assert challenge.description == "some updated description"
      assert challenge.difficulty == 43
      assert challenge.name == "some updated name"
    end

    test "update_challenge/2 with invalid data returns error changeset" do
      challenge = challenge_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_challenge(challenge, @invalid_attrs)
      assert challenge == Web.get_challenge!(challenge.id)
    end

    test "delete_challenge/1 deletes the challenge" do
      challenge = challenge_fixture()
      assert {:ok, %Challenge{}} = Web.delete_challenge(challenge)
      assert_raise Ecto.NoResultsError, fn -> Web.get_challenge!(challenge.id) end
    end

    test "change_challenge/1 returns a challenge changeset" do
      challenge = challenge_fixture()
      assert %Ecto.Changeset{} = Web.change_challenge(challenge)
    end
  end

  describe "recordings" do
    alias Userteam1.Web.Recording

    @valid_attrs %{path_to_recording: "some path_to_recording"}
    @update_attrs %{path_to_recording: "some updated path_to_recording"}
    @invalid_attrs %{path_to_recording: nil}

    def recording_fixture(attrs \\ %{}) do
      {:ok, recording} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_recording()

      recording
    end

    test "list_recordings/0 returns all recordings" do
      recording = recording_fixture()
      assert Web.list_recordings() == [recording]
    end

    test "get_recording!/1 returns the recording with given id" do
      recording = recording_fixture()
      assert Web.get_recording!(recording.id) == recording
    end

    test "create_recording/1 with valid data creates a recording" do
      assert {:ok, %Recording{} = recording} = Web.create_recording(@valid_attrs)
      assert recording.path_to_recording == "some path_to_recording"
    end

    test "create_recording/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_recording(@invalid_attrs)
    end

    test "update_recording/2 with valid data updates the recording" do
      recording = recording_fixture()
      assert {:ok, recording} = Web.update_recording(recording, @update_attrs)
      assert %Recording{} = recording
      assert recording.path_to_recording == "some updated path_to_recording"
    end

    test "update_recording/2 with invalid data returns error changeset" do
      recording = recording_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_recording(recording, @invalid_attrs)
      assert recording == Web.get_recording!(recording.id)
    end

    test "delete_recording/1 deletes the recording" do
      recording = recording_fixture()
      assert {:ok, %Recording{}} = Web.delete_recording(recording)
      assert_raise Ecto.NoResultsError, fn -> Web.get_recording!(recording.id) end
    end

    test "change_recording/1 returns a recording changeset" do
      recording = recording_fixture()
      assert %Ecto.Changeset{} = Web.change_recording(recording)
    end
  end

  describe "comments" do
    alias Userteam1.Web.Comment

    @valid_attrs %{message: "some message"}
    @update_attrs %{message: "some updated message"}
    @invalid_attrs %{message: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Web.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Web.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Web.create_comment(@valid_attrs)
      assert comment.message == "some message"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Web.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.message == "some updated message"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_comment(comment, @invalid_attrs)
      assert comment == Web.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Web.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Web.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Web.change_comment(comment)
    end
  end

  describe "infos" do
    alias Userteam1.Web.Info

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def info_fixture(attrs \\ %{}) do
      {:ok, info} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_info()

      info
    end

    test "list_infos/0 returns all infos" do
      info = info_fixture()
      assert Web.list_infos() == [info]
    end

    test "get_info!/1 returns the info with given id" do
      info = info_fixture()
      assert Web.get_info!(info.id) == info
    end

    test "create_info/1 with valid data creates a info" do
      assert {:ok, %Info{} = info} = Web.create_info(@valid_attrs)
      assert info.content == "some content"
    end

    test "create_info/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_info(@invalid_attrs)
    end

    test "update_info/2 with valid data updates the info" do
      info = info_fixture()
      assert {:ok, info} = Web.update_info(info, @update_attrs)
      assert %Info{} = info
      assert info.content == "some updated content"
    end

    test "update_info/2 with invalid data returns error changeset" do
      info = info_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_info(info, @invalid_attrs)
      assert info == Web.get_info!(info.id)
    end

    test "delete_info/1 deletes the info" do
      info = info_fixture()
      assert {:ok, %Info{}} = Web.delete_info(info)
      assert_raise Ecto.NoResultsError, fn -> Web.get_info!(info.id) end
    end

    test "change_info/1 returns a info changeset" do
      info = info_fixture()
      assert %Ecto.Changeset{} = Web.change_info(info)
    end
  end

  describe "challengegroups" do
    alias Userteam1.Web.ChallengeGroup

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def challenge_group_fixture(attrs \\ %{}) do
      {:ok, challenge_group} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Web.create_challenge_group()

      challenge_group
    end

    test "list_challengegroups/0 returns all challengegroups" do
      challenge_group = challenge_group_fixture()
      assert Web.list_challengegroups() == [challenge_group]
    end

    test "get_challenge_group!/1 returns the challenge_group with given id" do
      challenge_group = challenge_group_fixture()
      assert Web.get_challenge_group!(challenge_group.id) == challenge_group
    end

    test "create_challenge_group/1 with valid data creates a challenge_group" do
      assert {:ok, %ChallengeGroup{} = challenge_group} = Web.create_challenge_group(@valid_attrs)
      assert challenge_group.name == "some name"
    end

    test "create_challenge_group/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Web.create_challenge_group(@invalid_attrs)
    end

    test "update_challenge_group/2 with valid data updates the challenge_group" do
      challenge_group = challenge_group_fixture()
      assert {:ok, challenge_group} = Web.update_challenge_group(challenge_group, @update_attrs)
      assert %ChallengeGroup{} = challenge_group
      assert challenge_group.name == "some updated name"
    end

    test "update_challenge_group/2 with invalid data returns error changeset" do
      challenge_group = challenge_group_fixture()
      assert {:error, %Ecto.Changeset{}} = Web.update_challenge_group(challenge_group, @invalid_attrs)
      assert challenge_group == Web.get_challenge_group!(challenge_group.id)
    end

    test "delete_challenge_group/1 deletes the challenge_group" do
      challenge_group = challenge_group_fixture()
      assert {:ok, %ChallengeGroup{}} = Web.delete_challenge_group(challenge_group)
      assert_raise Ecto.NoResultsError, fn -> Web.get_challenge_group!(challenge_group.id) end
    end

    test "change_challenge_group/1 returns a challenge_group changeset" do
      challenge_group = challenge_group_fixture()
      assert %Ecto.Changeset{} = Web.change_challenge_group(challenge_group)
    end
  end
end

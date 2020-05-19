defmodule ProjectR0713225.UserContext do
  @moduledoc """
  The UserContext context.
  """

  import Ecto.Query, warn: false
  alias ProjectR0713225.Repo

  alias ProjectR0713225.UserContext.User

  defdelegate get_acceptable_roles(), to: User

  def authenticate_user(username, plain_text_password) do
    case Repo.get_by(User, username: username) do
      nil ->
        Pbkdf2.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Pbkdf2.verify_pass(plain_text_password, user.hashed_password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end

  def get_user(id), do: Repo.get(User, id)

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_user_no_role(attrs) do
    %User{}
    |> User.changeset_no_role(attrs)
    |> Repo.insert()
  end

  def change_user_no_role(%User{} = user) do
    User.changeset_no_role(user, %{})
  end

  def set_password_confirmation(user, password_confirmation) do
    %{user | password_confirmation: password_confirmation}
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  def does_username_exists?(username) do   
    query = from u in User, where: u.username == ^username
    Repo.exists?(query)
  end

  def update_user_password(%User{} = user, attrs) do
    user
    |> User.changeset_password(attrs)
    |> Repo.update()
  end

  def update_user_username(%User{} = user, attrs) do
    user
    |> User.changeset_username(attrs)
    |> Repo.update()
  end

  def set_hashed_password(user, hashed_password) do
    %{user | hashed_password: hashed_password}
  end

  def set_password(user, password) do
    %{user | password: password}
  end

  def set_oldpassword(user, oldpassword) do
    %{user | oldpassword: oldpassword}
  end

  def change_user_password(%User{} = user) do
    User.changeset_password(user, %{})
  end

  def change_user_username(%User{} = user) do
    User.changeset_username(user, %{})
  end

end

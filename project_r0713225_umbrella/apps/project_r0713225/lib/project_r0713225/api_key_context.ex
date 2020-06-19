defmodule ProjectR0713225.ApiKeyContext do
  @moduledoc """
  The ApiKeyContext context.
  """

  import Ecto.Query, warn: false
  alias ProjectR0713225.Repo
  alias ProjectR0713225.UserContext.User
  alias ProjectR0713225.ApiKeyContext.ApiKey
  alias ProjectR0713225.ApiKeyContext
  alias ProjectR0713225.UserContext
  

  def load_api_keys(%User{} = u), do: u |> Repo.preload([:apikeys])

  @doc """
  Returns the list of apikeys.

  ## Examples

      iex> list_apikeys()
      [%ApiKey{}, ...]

  """
  def list_apikeys do
    Repo.all(ApiKey)
  end


  def key_acces_to_write?(key)do
    Repo.exists?
    (from n in ApiKey, where: ^key == n.key and n.writeable == true)
  end

  @doc """
  Gets a single api_key.

  Raises Ecto.NoResultsError if the Api key does not exist.

  ## Examples

      iex> get_api_key!(123)
      %ApiKey{}

      iex> get_api_key!(456)
      ** (Ecto.NoResultsError)

  """
  def get_api_key!(id, user), do: Repo.get!(ApiKey, id)

  @doc """
  Creates a api_key.

  ## Examples

      iex> create_api_key(%{field: value})
      {:ok, %ApiKey{}}

      iex> create_api_key(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_api_key(attrs, %User{} = user) do
    %ApiKey{}
    |> ApiKey.create_changeset(attrs, user)
    |> Repo.insert()
  end

  @doc """
  Updates a api_key.
  ## Examples

      iex> update_api_key(api_key, %{field: new_value})
      {:ok, %ApiKey{}}

      iex> update_api_key(api_key, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_api_key(%ApiKey{} = api_key, attrs) do
    api_key
    |> ApiKey.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a api_key.

  ## Examples

      iex> delete_api_key(api_key)
      {:ok, %ApiKey{}}

      iex> delete_api_key(api_key)
      {:error, %Ecto.Changeset{}}

  """
  def delete_api_key(%ApiKey{} = api_key, user) do
    if(api_key.user_id == user.id) do
      Repo.delete(api_key)
  
    else
      {:unauthorized}
    end
  end

  @doc """
  Returns an %Ecto.Changeset{} for tracking api_key changes.

  ## Examples

      iex> change_api_key(api_key)
      %Ecto.Changeset{source: %ApiKey{}}

  """
  def change_api_key(%ApiKey{} = api_key) do
    ApiKey.changeset(api_key, %{})
  end

  def key_correct?(user_id, key) do
      Repo.exists?(from k in ApiKey, where: k.key == ^key and k.user_id == ^user_id)
  end

  def check_if_key_is_from_user!(id, user) do
      api = Repo.get!(ApiKey,  id)
      if api.user_id == user.id do
        {:ok, api}
      else
        {:unauthorized}
    end
  end
end
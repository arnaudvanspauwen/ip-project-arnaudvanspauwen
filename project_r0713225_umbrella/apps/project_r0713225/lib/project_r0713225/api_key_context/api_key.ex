defmodule ProjectR0713225.ApiKeyContext.ApiKey do
  use Ecto.Schema
  import Ecto.Changeset

  alias ProjectR0713225.UserContext.User

  schema "apikeys" do
    field :key, :string
    field :name, :string
    field :isWriteable, :boolean
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(api_key, attrs) do
    api_key
    |> cast(attrs, [:key, :name, :isWriteable])
    |> validate_required([:key, :name, :isWriteable])
  end
  

  def create_changeset(api_key, attrs, user) do
    api_key
    |> cast(attrs, [:name, :isWriteable])
    |> validate_required([:name, :isWriteable])
    |> put_assoc(:user, user)
    |> addkey()
  end

  ### geschreven methodes ###

  defp generate() do
    :crypto.strong_rand_bytes(64)
    |> Base.encode64
    |> binary_part(0,64)
  end

  defp addkey(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{name: name, isWriteable: isWriteable}} ->
        put_change(changeset, :key, generate())
          _->
          changeset
    end
  end

end

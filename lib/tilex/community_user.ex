defmodule Tilex.CommunityUser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "community_users" do
    field(:email, :string)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(community_user, attrs \\ %{}) do
    community_user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end

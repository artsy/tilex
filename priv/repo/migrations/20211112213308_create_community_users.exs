defmodule Tilex.Repo.Migrations.CreateCommunityUsers do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS citext", "DROP EXTENSION citext")

    create table(:community_users) do
      add(:name, :string, null: false)
      add(:email, :citext, null: false)

      timestamps()
    end

    create(unique_index(:community_users, [:email]))
  end
end

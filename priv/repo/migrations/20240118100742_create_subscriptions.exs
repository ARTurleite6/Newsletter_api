defmodule Newsletter.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :email, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:subscriptions, [:email])
  end
end

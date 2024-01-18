defmodule Newsletter.Repo.Migrations.CreateSpecialties do
  use Ecto.Migration

  def change do
    create table(:specialties) do
      add :date, :date
      add :restaurant, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:specialties, [:date, :restaurant])
  end
end

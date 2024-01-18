defmodule Newsletter.Repo.Migrations.CreateDishes do
  use Ecto.Migration

  def change do
    create table(:dishes) do
      add :name, :string
      add :specialty_id, references(:specialties, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end
  end
end

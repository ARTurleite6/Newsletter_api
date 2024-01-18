defmodule Newsletter.Specialties.Dish do
  use Ecto.Schema
  import Ecto.Changeset

  schema "dishes" do
    field :name, :string

    belongs_to :specialty, Newsletter.Specialties.Specialty
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(dish, attrs) do
    dish
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

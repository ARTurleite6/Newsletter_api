defmodule Newsletter.Specialties.Specialty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "specialties" do
    field :date, :date
    field :restaurant, :string
    has_many :dishes, Newsletter.Specialties.Dish

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(specialty, attrs) do
    specialty
    |> cast(attrs, [:date, :restaurant])
    |> cast_assoc(:dishes)
    |> validate_required([:date, :restaurant])
    |> unique_constraint([:date, :restaurant])
  end
end

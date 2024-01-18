defmodule NewsletterWeb.SpecialtyJSON do
  alias Newsletter.Specialties.Specialty
  alias Newsletter.Specialties.Dish

  @doc """
  Renders a list of specialties.
  """
  def index(%{specialties: specialties}) do
    %{data: for(specialty <- specialties, do: data(specialty))}
  end

  @doc """
  Renders a single specialty.
  """
  def show(%{specialty: specialty}) do
    %{data: data(specialty)}
  end

  defp data(%Specialty{} = specialty) do
    %{
      id: specialty.id,
      date: specialty.date,
      restaurant: specialty.restaurant,
      dishes: for(dish <- specialty.dishes, do: dish_data(dish))
    }
  end

  defp dish_data(%Dish{} = dish) do
    dish.name
  end
end

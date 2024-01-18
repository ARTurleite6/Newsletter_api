defmodule Newsletter.SpecialtiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newsletter.Specialties` context.
  """

  @doc """
  Generate a specialty.
  """
  def specialty_fixture(attrs \\ %{}) do
    {:ok, specialty} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-01-17],
        restaurant: "some restaurant"
      })
      |> Newsletter.Specialties.create_specialty()

    specialty
  end

  @doc """
  Generate a dish.
  """
  def dish_fixture(attrs \\ %{}) do
    {:ok, dish} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Newsletter.Specialties.create_dish()

    dish
  end
end

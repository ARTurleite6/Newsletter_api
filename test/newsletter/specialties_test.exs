defmodule Newsletter.SpecialtiesTest do
  use Newsletter.DataCase

  alias Newsletter.Specialties

  describe "specialties" do
    alias Newsletter.Specialties.Specialty

    import Newsletter.SpecialtiesFixtures

    @invalid_attrs %{date: nil, restaurant: nil}

    test "list_specialties/0 returns all specialties" do
      specialty = specialty_fixture()
      assert Specialties.list_specialties() == [specialty]
    end

    test "get_specialty!/1 returns the specialty with given id" do
      specialty = specialty_fixture()
      assert Specialties.get_specialty!(specialty.id) == specialty
    end

    test "create_specialty/1 with valid data creates a specialty" do
      valid_attrs = %{date: ~D[2024-01-17], restaurant: "some restaurant"}

      assert {:ok, %Specialty{} = specialty} = Specialties.create_specialty(valid_attrs)
      assert specialty.date == ~D[2024-01-17]
      assert specialty.restaurant == "some restaurant"
    end

    test "create_specialty/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Specialties.create_specialty(@invalid_attrs)
    end

    test "update_specialty/2 with valid data updates the specialty" do
      specialty = specialty_fixture()
      update_attrs = %{date: ~D[2024-01-18], restaurant: "some updated restaurant"}

      assert {:ok, %Specialty{} = specialty} = Specialties.update_specialty(specialty, update_attrs)
      assert specialty.date == ~D[2024-01-18]
      assert specialty.restaurant == "some updated restaurant"
    end

    test "update_specialty/2 with invalid data returns error changeset" do
      specialty = specialty_fixture()
      assert {:error, %Ecto.Changeset{}} = Specialties.update_specialty(specialty, @invalid_attrs)
      assert specialty == Specialties.get_specialty!(specialty.id)
    end

    test "delete_specialty/1 deletes the specialty" do
      specialty = specialty_fixture()
      assert {:ok, %Specialty{}} = Specialties.delete_specialty(specialty)
      assert_raise Ecto.NoResultsError, fn -> Specialties.get_specialty!(specialty.id) end
    end

    test "change_specialty/1 returns a specialty changeset" do
      specialty = specialty_fixture()
      assert %Ecto.Changeset{} = Specialties.change_specialty(specialty)
    end
  end

  describe "dishes" do
    alias Newsletter.Specialties.Dish

    import Newsletter.SpecialtiesFixtures

    @invalid_attrs %{name: nil}

    test "list_dishes/0 returns all dishes" do
      dish = dish_fixture()
      assert Specialties.list_dishes() == [dish]
    end

    test "get_dish!/1 returns the dish with given id" do
      dish = dish_fixture()
      assert Specialties.get_dish!(dish.id) == dish
    end

    test "create_dish/1 with valid data creates a dish" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Dish{} = dish} = Specialties.create_dish(valid_attrs)
      assert dish.name == "some name"
    end

    test "create_dish/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Specialties.create_dish(@invalid_attrs)
    end

    test "update_dish/2 with valid data updates the dish" do
      dish = dish_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Dish{} = dish} = Specialties.update_dish(dish, update_attrs)
      assert dish.name == "some updated name"
    end

    test "update_dish/2 with invalid data returns error changeset" do
      dish = dish_fixture()
      assert {:error, %Ecto.Changeset{}} = Specialties.update_dish(dish, @invalid_attrs)
      assert dish == Specialties.get_dish!(dish.id)
    end

    test "delete_dish/1 deletes the dish" do
      dish = dish_fixture()
      assert {:ok, %Dish{}} = Specialties.delete_dish(dish)
      assert_raise Ecto.NoResultsError, fn -> Specialties.get_dish!(dish.id) end
    end

    test "change_dish/1 returns a dish changeset" do
      dish = dish_fixture()
      assert %Ecto.Changeset{} = Specialties.change_dish(dish)
    end
  end
end

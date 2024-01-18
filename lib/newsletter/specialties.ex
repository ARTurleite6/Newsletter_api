defmodule Newsletter.Specialties do
  @moduledoc """
  The Specialties context.
  """

  import Ecto.Query, warn: false
  alias Newsletter.Mailer
  alias Newsletter.Subscriptions
  alias Newsletter.Repo

  alias Newsletter.Specialties.Specialty

  @doc """
  Returns the list of specialties.

  ## Examples

      iex> list_specialties()
      [%Specialty{}, ...]

  """
  def list_specialties do
    Repo.all(Specialty) |> Repo.preload(:dishes)
  end

  def get_specialties_by_day!(day) do
    Specialty |> where([s], s.date == ^day) |> Repo.all() |> Repo.preload(:dishes)
  end

  def send_email do
    specialties = get_specialties_by_day!(Date.utc_today())

    Subscriptions.list_subscriptions()
    |> Enum.map(fn subscription ->
      Mailer.send_specialties_of_day(specialties, subscription)
    end)
    |> Mailer.deliver_many()
  end

  @doc """
  Gets a single specialty.

  Raises `Ecto.NoResultsError` if the Specialty does not exist.

  ## Examples

      iex> get_specialty!(123)
      %Specialty{}

      iex> get_specialty!(456)
      ** (Ecto.NoResultsError)

  """
  def get_specialty!(id) do
    Repo.get!(Specialty, id)
    |> Repo.preload(:dishes)
  end

  @doc """
  Creates a specialty.

  ## Examples

      iex> create_specialty(%{field: value})
      {:ok, %Specialty{}}

      iex> create_specialty(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_specialty(attrs \\ %{}) do
    %Specialty{}
    |> Specialty.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a specialty.

  ## Examples

      iex> update_specialty(specialty, %{field: new_value})
      {:ok, %Specialty{}}

      iex> update_specialty(specialty, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_specialty(%Specialty{} = specialty, attrs) do
    specialty
    |> Specialty.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a specialty.

  ## Examples

      iex> delete_specialty(specialty)
      {:ok, %Specialty{}}

      iex> delete_specialty(specialty)
      {:error, %Ecto.Changeset{}}

  """
  def delete_specialty(%Specialty{} = specialty) do
    Repo.delete(specialty)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking specialty changes.

  ## Examples

      iex> change_specialty(specialty)
      %Ecto.Changeset{data: %Specialty{}}

  """
  def change_specialty(%Specialty{} = specialty, attrs \\ %{}) do
    Specialty.changeset(specialty, attrs)
  end

  alias Newsletter.Specialties.Dish

  @doc """
  Returns the list of dishes.

  ## Examples

      iex> list_dishes()
      [%Dish{}, ...]

  """
  def list_dishes do
    Repo.all(Dish)
  end

  @doc """
  Gets a single dish.

  Raises `Ecto.NoResultsError` if the Dish does not exist.

  ## Examples

      iex> get_dish!(123)
      %Dish{}

      iex> get_dish!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dish!(id), do: Repo.get!(Dish, id)

  @doc """
  Creates a dish.

  ## Examples

      iex> create_dish(%{field: value})
      {:ok, %Dish{}}

      iex> create_dish(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dish(attrs \\ %{}) do
    %Dish{}
    |> Dish.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dish.

  ## Examples

      iex> update_dish(dish, %{field: new_value})
      {:ok, %Dish{}}

      iex> update_dish(dish, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dish(%Dish{} = dish, attrs) do
    dish
    |> Dish.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dish.

  ## Examples

      iex> delete_dish(dish)
      {:ok, %Dish{}}

      iex> delete_dish(dish)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dish(%Dish{} = dish) do
    Repo.delete(dish)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dish changes.

  ## Examples

      iex> change_dish(dish)
      %Ecto.Changeset{data: %Dish{}}

  """
  def change_dish(%Dish{} = dish, attrs \\ %{}) do
    Dish.changeset(dish, attrs)
  end
end

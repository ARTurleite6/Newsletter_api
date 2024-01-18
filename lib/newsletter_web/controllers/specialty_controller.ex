defmodule NewsletterWeb.SpecialtyController do
  use NewsletterWeb, :controller

  alias Newsletter.Specialties
  alias Newsletter.Specialties.Specialty

  action_fallback NewsletterWeb.FallbackController

  def index(conn, _params) do
    specialties = Specialties.list_specialties()
    render(conn, :index, specialties: specialties)
  end

  def create(conn, %{"specialty" => specialty_params}) do
    with {:ok, %Specialty{} = specialty} <- Specialties.create_specialty(specialty_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/specialties/#{specialty}")
      |> render(:show, specialty: specialty)
    end
  end

  def show(conn, %{"id" => id}) do
    specialty = Specialties.get_specialty!(id)
    IO.inspect(specialty)
    render(conn, :show, specialty: specialty)
  end

  def update(conn, %{"id" => id, "specialty" => specialty_params}) do
    specialty = Specialties.get_specialty!(id)

    with {:ok, %Specialty{} = specialty} <-
           Specialties.update_specialty(specialty, specialty_params) do
      render(conn, :show, specialty: specialty)
    end
  end

  def delete(conn, %{"id" => id}) do
    specialty = Specialties.get_specialty!(id)

    with {:ok, %Specialty{}} <- Specialties.delete_specialty(specialty) do
      send_resp(conn, :no_content, "")
    end
  end
end

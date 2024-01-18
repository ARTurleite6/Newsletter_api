defmodule NewsletterWeb.SpecialtyControllerTest do
  use NewsletterWeb.ConnCase

  import Newsletter.SpecialtiesFixtures

  alias Newsletter.Specialties.Specialty

  @create_attrs %{
    date: ~D[2024-01-17],
    restaurant: "some restaurant"
  }
  @update_attrs %{
    date: ~D[2024-01-18],
    restaurant: "some updated restaurant"
  }
  @invalid_attrs %{date: nil, restaurant: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all specialties", %{conn: conn} do
      conn = get(conn, ~p"/api/specialties")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create specialty" do
    test "renders specialty when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/specialties", specialty: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/specialties/#{id}")

      assert %{
               "id" => ^id,
               "date" => "2024-01-17",
               "restaurant" => "some restaurant"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/specialties", specialty: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update specialty" do
    setup [:create_specialty]

    test "renders specialty when data is valid", %{conn: conn, specialty: %Specialty{id: id} = specialty} do
      conn = put(conn, ~p"/api/specialties/#{specialty}", specialty: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/specialties/#{id}")

      assert %{
               "id" => ^id,
               "date" => "2024-01-18",
               "restaurant" => "some updated restaurant"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, specialty: specialty} do
      conn = put(conn, ~p"/api/specialties/#{specialty}", specialty: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete specialty" do
    setup [:create_specialty]

    test "deletes chosen specialty", %{conn: conn, specialty: specialty} do
      conn = delete(conn, ~p"/api/specialties/#{specialty}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/specialties/#{specialty}")
      end
    end
  end

  defp create_specialty(_) do
    specialty = specialty_fixture()
    %{specialty: specialty}
  end
end

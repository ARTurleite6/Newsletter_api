defmodule NewsletterWeb.SubscriptionControllerTest do
  use NewsletterWeb.ConnCase

  import Newsletter.SubscriptionsFixtures

  alias Newsletter.Subscriptions.Subscription

  @create_attrs %{
    email: "some email"
  }
  @update_attrs %{
    email: "some updated email"
  }
  @invalid_attrs %{email: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all subscriptions", %{conn: conn} do
      conn = get(conn, ~p"/api/subscriptions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create subscription" do
    test "renders subscription when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/subscriptions", subscription: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/subscriptions/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/subscriptions", subscription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update subscription" do
    setup [:create_subscription]

    test "renders subscription when data is valid", %{conn: conn, subscription: %Subscription{id: id} = subscription} do
      conn = put(conn, ~p"/api/subscriptions/#{subscription}", subscription: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/subscriptions/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some updated email"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, subscription: subscription} do
      conn = put(conn, ~p"/api/subscriptions/#{subscription}", subscription: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete subscription" do
    setup [:create_subscription]

    test "deletes chosen subscription", %{conn: conn, subscription: subscription} do
      conn = delete(conn, ~p"/api/subscriptions/#{subscription}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/subscriptions/#{subscription}")
      end
    end
  end

  defp create_subscription(_) do
    subscription = subscription_fixture()
    %{subscription: subscription}
  end
end

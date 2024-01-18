defmodule Newsletter.SubscriptionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Newsletter.Subscriptions` context.
  """

  @doc """
  Generate a unique subscription email.
  """
  def unique_subscription_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a subscription.
  """
  def subscription_fixture(attrs \\ %{}) do
    {:ok, subscription} =
      attrs
      |> Enum.into(%{
        email: unique_subscription_email()
      })
      |> Newsletter.Subscriptions.create_subscription()

    subscription
  end
end

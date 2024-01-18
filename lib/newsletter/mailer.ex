defmodule Newsletter.Mailer do
  alias Newsletter.Subscriptions.Subscription

  use Swoosh.Mailer, otp_app: :newsletter

  use Phoenix.Swoosh,
    template_root: "lib/newsletter_web/templates/emails",
    template_path: "specialties_email"

  def send_specialties_of_day(specialties, subscriber = %Subscription{}) do
    new()
    |> to({"Subscriber", subscriber.email})
    |> from({"Newsletter", "arturleite164@gmail.com"})
    |> subject("Specialties of the day:")
    |> render_body("specialties.html", %{specialties: specialties})
  end
end

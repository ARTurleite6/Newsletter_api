defmodule Newsletter.Scheduler do
  use Application

  def start(_type, _args) do
    children = [
      Newsletter.MailScheduler
    ]

    opts = [strategy: :one_for_one, name: Newsletter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

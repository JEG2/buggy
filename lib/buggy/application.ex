defmodule Buggy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    Logger.remove_backend(:console)

    children = [
      # Starts a worker by calling: Buggy.Worker.start_link(arg)
      {Buggy.RPNCalculator, [options: [name: Buggy.RPNCalculator]]},
      {Buggy.SimulatedUser, [options: [name: Buggy.SimulatedUser]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Buggy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

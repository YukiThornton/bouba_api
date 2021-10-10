defmodule BoubaApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    port = port()

    children = [
      {Plug.Cowboy, scheme: :http, plug: BoubaApi.Router, options: [port: port]}
      # Starts a worker by calling: BoubaApi.Worker.start_link(arg)
      # {BoubaApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BoubaApi.Supervisor]

    Logger.info("Starting application on port=#{port}")
    Supervisor.start_link(children, opts)
  end

  defp port, do: Application.get_env(:bouba_api, :port, 7890)
end

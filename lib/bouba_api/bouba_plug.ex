defmodule BoubaApi.BoubaPlug do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _ops) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Bouba!")
  end
end

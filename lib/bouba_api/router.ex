defmodule BoubaApi.Router do
  use Plug.Router
  use Plug.ErrorHandler

  alias BoubaApi.Plug.VerifyRequest

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(VerifyRequest, fields: ["content", "mimetype"], paths: ["/upload"])

  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "bouba")
  end

  get "/kiki" do
    conn = put_resp_header(conn, "content-type", "application/json")
    send_resp(conn, 200, Jason.encode!(%{"isBouba" => false}))
  end

  get "/upload" do
    send_resp(conn, 201, "uploaded")
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    IO.inspect(kind, label: :kind)
    IO.inspect(reason, label: :reason)
    IO.inspect(stack, label: :stack)
    send_resp(conn, conn.status, "Something went wrong")
  end
end

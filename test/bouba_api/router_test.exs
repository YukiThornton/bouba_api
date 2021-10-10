defmodule BoubaApi.RouterTest do
  use ExUnit.Case
  use Plug.Test

  alias BoubaApi.Router

  @opts Router.init([])
  @content "<html><body>Hi!</body></html>"
  @mimetype "text/html"

  test "returns bouba" do
    conn =
      :get
      |> conn("/", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "returns false for bouba" do
    conn =
      :get
      |> conn("/kiki", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert get_resp_header(conn, "content-type") == ["application/json"]
    assert Jason.decode!(conn.resp_body) == %{"isBouba" => false}
  end

  test "returns 404" do
    conn =
      :get
      |> conn("/unknown", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404
  end

  test "returns uploaded" do
    conn =
      :get
      |> conn("/upload?content=#{@content}&mimetype=#{@mimetype}")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 201
  end
end

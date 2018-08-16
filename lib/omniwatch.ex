defmodule Omniwatch do
  @moduledoc """
    OmniWatch is an Elixir of the Omni Api
  """
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "https://api.omniexplorer.info")
  plug(Tesla.Middleware.FormUrlencoded)

  def grants do
    # 10 transactions is the max
    {:ok, response} = post("/v1/properties/gethistory/3", "page=0")

    response.body
    |> Poison.decode!()
  end

  def addresses_balances(addr_list) do
    query =
      Enum.map(addr_list, &{"addr", &1})
      |> URI.encode_query()

    {:ok, response} = post("/v2/address/addr/", query)

    response.body
    |> Poison.decode!()
  end

  def address_details(addr) do
    {:ok, response} = post("/v1/address/addr/details/", "addr=#{addr}")

    response.body
    |> Poison.decode!()
  end

  def property_list do
    {:ok, response} = get("/v1/properties/list")

    response.body
    |> Poison.decode!()
  end

  # def monitored_addresses do
  #   [
  #     "1NTMakcgVwQpMdGxRQnFKyb3G1FAJysSfz"
  #   ]
  # end
end

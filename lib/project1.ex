defmodule PROJECT1 do
  @moduledoc """
  Documentation for PROJECT1.
  """

  def main(args) do
    inputstring = "GoGators"
    input_arguements = (List.to_string(args))

    if String.contains?(input_arguements,".") do
      IO.puts("This is a slave machine, it should contact the server and only do mining")
    else
      IO.puts("This IS a SERVER machine, it will spawn 3 threads, for mining, generating input string and printing output on the terminal")
      k = String.to_integer(input_arguements)
      string2 = String.duplicate("0",k)
      PROJECT1.Miner.minecoins(0,inputstring, string2)
    end
  end
end
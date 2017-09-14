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
      spawnXminingThreads(0, 100, inputstring, string2)     
    end

    PROJECT1.OutputPrinter.listen()

  end

  def spawnXminingThreads(count, intx, inputstring, string2) when count < intx do
    IO.puts(count)
    spawn(PROJECT1.Miner,:minecoins, [self(), 0, PROJECT1.InputStringGenerator.get_new_input(inputstring), string2])
    spawnXminingThreads(count+1,intx, inputstring, string2)
  end

  def spawnXminingThreads(count, intx, inputstring, string2) when count >= intx do
    IO.puts(intx)
  end

  #def spawnAminingThread(inputstring, string2) do
  #  PROJECT1.Miner.minecoins(0,PROJECT1.InputStringGenerator.get_new_input(inputstring), string2)
  #end
  
end
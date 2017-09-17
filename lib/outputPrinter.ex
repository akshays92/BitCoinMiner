defmodule PROJECT1.OutputPrinter do
  
  def listen() do
      receive do
        {:ok,message} -> PROJECT1.Server.getOutputString(:CoinServer, message)
      end
      listen()
  end

end

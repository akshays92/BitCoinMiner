defmodule PROJECT1.OutputPrinter do
  
  def listen() do
      receive do
        {:ok,message} -> IO.puts message
      end
      listen()
  end

end

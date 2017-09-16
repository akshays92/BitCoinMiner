defmodule PROJECT1.Server do
    use GenServer

      def start_link do
        GenServer.start_link(__MODULE__,0, name: :CoinServer)
      end
      
      def init(init_data) do
        IO.puts("Server started")
        {:ok,init_data} 
        end
    
      def getInputString(:CoinServer, baseString) do
          GenServer.call(:CoinServer, {:getInputString, baseString})
      end
        
      #callbacks
      
      def handle_call({:getInputString, baseString}, _from, my_state) do
        x = Integer.to_string(my_state,36)
        {:reply, (baseString <> String.duplicate("0",5-String.length(x)) <> x ), my_state+1}
      end    
end
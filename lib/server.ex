defmodule PROJECT1.Server do
    use GenServer

      def start_link do
        GenServer.start_link(__MODULE__,0, name: :CoinServer)
      end
      
      def init(init_data) do
        IO.puts("Server started")
        {:ok,init_data} 
        end
    
      #def start_link do
      #      GenServer.start_link(__MODULE__,"Hello")
      #end
          
      #def init(init_data) do
      #      IO.puts("greetings init")
      #      greetings=%{:greeting => init_data}
      #      {:ok, greetings}
      #end
        
      def getInputString(:CoinServer, baseString) do
          GenServer.call(:CoinServer, {:getInputString, baseString})
      end
        
      #callbacks
           
      def handle_call({:getInputString, baseString}, _from, my_state) do
        IO.puts( baseString <> Integer.to_string(my_state,36))
        {:reply, baseString <> Integer.to_string(my_state,36), my_state+1}
  end

end
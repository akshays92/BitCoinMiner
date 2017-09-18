defmodule PROJECT1.Server do
    use GenServer

      def start_link(k, commonString) do
        GenServer.start_link(__MODULE__,%{k: k, pc: 0, commonString: commonString}, name: :CoinServer)
      end
      
      def init(init_data) do
        {:ok,init_data} 
        end
    
      def getInputString(sname) do
          GenServer.call(sname, {:getInputString})
      end
      
      def printOutputString(sname, outputString ) do
          GenServer.cast(sname, {:getOutputString, outputString})
      end

      def getK(sname) do
        GenServer.call(sname, {:get_k})
      end


      #callbacks
      
      def handle_cast({:getOutputString, outputString}, my_state) do
        IO.puts outputString
        {:noreply, my_state}
        
      end 

      def handle_call({:getInputString}, _from, my_state) do
        x = Integer.to_string(Map.get(my_state, :pc),36)
        commonString=Map.get(my_state, :commonString)
        {:reply, (commonString <> String.duplicate("0",5-String.length(x)) <> x ), Map.put(my_state, :pc, Map.get(my_state, :pc) + 1)}
      end    

      def handle_call({:get_k}, _from, state) do
        {:reply, Map.get(state, :k), state}
      end
end



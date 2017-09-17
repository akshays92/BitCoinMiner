defmodule PROJECT1 do
  @moduledoc """
  Documentation for PROJECT1.
  """
  def main(args) do
    inputstring = "GoGator"
    input_arguements = (List.to_string(args))

    if String.contains?(input_arguements,".") do
      IO.puts("This is a slave machine, it should contact the server and only do mining")
      
      #get random connection atom to spawn this node
      IO.inspect Node.start(PROJECT1.ConnectionAtomGenerator.get_connection_atom("192.168.0.13")) 
      IO.inspect Node.set_cookie(:"DesiBitcoinFarm")


      #server connection atom
      serveratom=String.to_atom("Server"<>"@"<>args)
      IO.inspect Node.connect(serveratom)
      IO.inspect k = GenServer.call({:CoinServer,serveratom}, {:get_k})
      IO.inspect string2 = String.duplicate("0",k)
      IO.inspect sname = {:CoinServer, serveratom}
      spawnXminingThreads(sname, 0, 36, inputstring, string2, 1)
      PROJECT1.OutputPrinter.listen()
    else
      IO.puts("This IS a SERVER machine, it will spawn 3 threads, for mining, generating input string and printing output on the terminal")
      serveratom=String.to_atom("Server"<>"@"<>"192.168.0.16")
      Node.start(serveratom)
      Node.set_cookie(:"DesiBitcoinFarm")
      k = String.to_integer(input_arguements)
      string2 = String.duplicate("0",k)
      PROJECT1.Server.start_link(k)
      sname = {:CoinServer, serveratom}
      spawnXminingThreads(sname, 0, 36, inputstring, string2, 0)
      PROJECT1.OutputPrinter.listen()
    end

    

  end

  def spawnXminingThreads(sname, count, intx, inputstring, string2, val) when count < intx do
    spawn(PROJECT1.Miner,:minecoins, [sname, 0, PROJECT1.Server.getInputString(sname,inputstring), string2, val])
    spawnXminingThreads(sname, count+1,intx, inputstring, string2, val)
  end

  def spawnXminingThreads(sname, count, intx, inputstring, string2, val) when count >= intx do
    #IO.puts(intx)
  end

  #def spawnAminingThread(inputstring, string2) do
  #  PROJECT1.Miner.minecoins(0,PROJECT1.InputStringGenerator.get_new_input(inputstring), string2)
  #end

  def findIP() do
    {ops_sys, _ } = :os.type
    ip = 
    case ops_sys do
     :unix -> {:ok, [addr: ip]} = :inet.ifget('en0', [:addr])
     to_string(:inet.ntoa(ip))
     :win32 -> {:ok, [ip, _]} = :inet.getiflist
     to_string(ip)
    end
    (ip)
  end
  
end
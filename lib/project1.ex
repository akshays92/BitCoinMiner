defmodule PROJECT1 do
  @moduledoc """
  Documentation for PROJECT1.
  """
  def main(args) do
    inputstring = "pbrahme;"
    input_arguements = (List.to_string(args))
    numberOfMiningThreadsPerCore=25
    localIP=findIP #change with getting localIP address for different operating systems

    if String.contains?(input_arguements,".") do
      #IO.puts("This is a slave machine, it should contact the server and only do mining")
      serverIP = input_arguements
      
      #get random connection atom to spawn this node
      Node.start(PROJECT1.ConnectionAtomGenerator.get_connection_atom(localIP))
      Node.set_cookie(:"DesiBitcoinFarm")
      
      #server connection atom
      serveratom=String.to_atom("Server"<>"@"<>serverIP)
      Node.connect(serveratom)
      k = GenServer.call({:CoinServer,serveratom}, {:get_k})
      string2 = String.duplicate("0",k)
      sname = {:CoinServer, serveratom}
      spawnXminingThreads(sname, 0,  :erlang.system_info(:logical_processors_available)*numberOfMiningThreadsPerCore, inputstring, string2, 1)
    else
      #IO.puts("This IS a SERVER machine, it will spawn 3 threads, for mining, generating input string and printing output on the terminal")
      serverIP=localIP
      serveratom=String.to_atom("Server"<>"@"<>serverIP)
      Node.start(serveratom)
      Node.set_cookie(:"DesiBitcoinFarm")
      k = String.to_integer(input_arguements)
      string2 = String.duplicate("0",k)
      PROJECT1.Server.start_link(k)
      sname = {:CoinServer, serveratom}
      spawnXminingThreads(sname, 0,:erlang.system_info(:logical_processors_available)*numberOfMiningThreadsPerCore, inputstring, string2, 0)

    end

    

  end

  def spawnXminingThreads(sname, count, intx, inputstring, string2, val) when count < intx do
    spawn(PROJECT1.Miner,:minecoins, [sname, 0, PROJECT1.Server.getInputString(sname,inputstring), string2, val])
    spawnXminingThreads(sname, count+1,intx, inputstring, string2, val)
  end

  def spawnXminingThreads(sname, count, intx, inputstring, string2, val) when count >= intx do
    #IO.puts("starting unlimited loop")
    unlimitedLoop()
  end

  def findIP do
    {ops_sys, versionof } = :os.type
    ip = 
    case ops_sys do
     :unix -> 
      case versionof do
        :darwin -> {:ok, [addr: ip]} = :inet.ifget('en0', [:addr])
        to_string(:inet.ntoa(ip)) 
        :linux ->  {:ok, [addr: ip]} = :inet.ifget('wlp1s0', [:addr])
        to_string(:inet.ntoa(ip))
      end    
      :win32 -> {:ok, ip} = :inet.getiflist
      to_string(hd(ip))
    end
    (ip)
  end

  def unlimitedLoop() do
    unlimitedLoop()
  end
  
end
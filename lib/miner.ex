defmodule PROJECT1.Miner do
    
    def minecoins(pid, count, inputstring, string2) do
        countStr = Integer.to_string(count)
        shaString = String.downcase(:crypto.hash(:sha256, inputstring <> countStr) |> Base.encode16)
        if String.starts_with?(shaString, string2) do
          output = (inputstring <> countStr <> "\t" <> shaString)
          send(pid, {:ok, output})
          
        end
        minecoins(pid, count+1, inputstring, string2)
    end
end


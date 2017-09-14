defmodule PROJECT1.Miner do
    
    def minecoins(count, inputstring, string2) do
        countStr = Integer.to_string(count)
        shaString = String.downcase(:crypto.hash(:sha256, inputstring <> countStr) |> Base.encode16)
        if String.starts_with?(shaString, string2) do
          output = (inputstring <> countStr <> "\t" <> shaString)
          IO.puts(output)
          
        end
        minecoins(count+1, inputstring, string2)
      end
end
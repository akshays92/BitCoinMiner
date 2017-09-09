defmodule PROJECT1 do
  @moduledoc """
  Documentation for PROJECT1.
  """

  @doc """
  Hello world.

  ## Examples

      iex> PROJECT1.hello
      :world

  """
  def hello do
    :world
  end
  def main(args) do
    IO.puts "Number of zeros taken: #{args}"
    IO.puts(:crypto.hash(:sha256,"adobra;kjsdfk11" ) |> Base.encode16)
  end

end

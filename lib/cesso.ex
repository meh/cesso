#          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                  Version 2, December 2004
#
#          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
# TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 
#
# 0. You just DO WHAT THE FUCK YOU WANT TO.

defmodule Cesso do
  alias Cesso.Parser

  def decode(string, options // []) do
    rows = Parser.parse(string, options)

    if options[:columns] do
      case options[:columns] do
        true ->
          names = rows |> Enum.first
          rows  = rows |> Stream.drop(1)

        names ->
          names = names
      end

      rows = rows |> Stream.map fn columns ->
        Enum.zip(names, columns)
      end
    end

    if as = options[:as] do
      rows = rows |> Stream.map fn columns ->
        if options[:columns] do
          as.new(columns)
        else
          [as | columns] |> list_to_tuple
        end
      end
    end

    rows
  end
end

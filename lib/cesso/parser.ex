#          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                  Version 2, December 2004
#
#          DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
# TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION 
#
# 0. You just DO WHAT THE FUCK YOU WANT TO.

defmodule Cesso.Parser do
  defrecordp :options, separator: nil

  def parse(string, options // []) do
    separator = case options[:separator] do
      nil ->
        ?,

      << sep :: utf8 >> ->
        sep

      sep when sep |> is_integer ->
        sep
    end

    rows(string) |> Stream.map &columns(&1, options(separator: separator))
  end

  def rows(string) do
    Stream.unfold string, fn string ->
      case string |> :binary.split ["\r\n", "\n"] do
        [""] ->
          nil

        [left] ->
          { left, "" }

        [left, right] ->
          { left, right }
      end
    end
  end

  def columns("", _) do
    []
  end

  def columns(line, options) do
    columns([], line, options) |> :lists.reverse
  end

  def columns(acc, line, options(separator: separator) = options) do
    case until("", line, separator) do
      { element, "" } ->
        [element | acc]

      { element, rest } ->
        [element | acc] |> columns(rest, options)
    end
  end

  def until(acc, "", _) do
    { acc, "" }
  end

  def until(acc, << separator :: 8, rest :: binary >>, separator) do
    { acc, rest }
  end

  def until(acc, << ch :: 8, rest :: binary >>, separator) do
    << acc :: binary, ch :: 8 >> |> until(rest, separator)
  end
end

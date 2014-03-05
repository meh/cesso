defmodule ParserTest do
  use ExUnit.Case
  alias Cesso.Parser, as: P
  import Enum, only: [to_list: 1]

  test "parses a string" do
    assert to_list(P.parse(~S<lol,wut>)) == [["lol", "wut"]]
  end

  test "parses an enum" do
    assert to_list(P.parse(["lol,wut"])) == [["lol", "wut"]]
  end

  test "parses with a different separator" do
    assert to_list(P.parse(~s<lol;wut>, separator: ";")) == [["lol", "wut"]]
  end

  test "parses with a multichar separator" do
    assert to_list(P.parse(~s<lol|||wut>, separator: "|||")) == [["lol", "wut"]]
  end

  test "parses column strings" do
    assert to_list(P.parse(~s<lol,"wut,">)) == [["lol", "wut,"]]
  end

  test "parses a column string with a multiline" do
    assert to_list(P.parse(~s<lol,"wut\nomg">)) == [["lol", "wut\nomg"]]
  end
end

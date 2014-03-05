cesso - CSV parser for Elixir
=============================

Simple library to parse CSV lazily, especially made to parse huge exported
databases.

Examples
--------

```elixir
CSV.decode(~s<lol,wut>)
  |> IO.inspect # => [["lol", "wut"]]

# string columns are supported
CSV.decode(~s<lol,"wut,omg">)
  |> IO.inspect # => [["lol", "wut,omg"]]

# they can also span multiple lines
CSV.decode(~s<lol,"wut\nomg",hue>)
  |> IO.inspect # => [["lol", "wut\nomg", "hue"]]

# you can also specify a different separator
CSV.decode(~s<lol|||wut>, separator: "|||")
  |> IO.inspect # => [["lol", "wut"]]

# the first row can be used as column names
CSV.decode(~s<a,b\nlol,wut>, columns: true)
  |> IO.inspect [[{ "a", "lol" }, { "b", "wut" }]]

# otherwise you can pass the column names
CSV.decode(~s<lol,wut>, columns: ["a", "b"])
 |> IO.inspect [[{ "a", "lol" }, { "b", "wut" }]]

# you can also parse a file
CSV.decode(File.stream!("db.csv"))
```

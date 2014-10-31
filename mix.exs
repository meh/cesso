defmodule Cesso.Mixfile do
  use Mix.Project

  def project do
    [ app: :cesso,
      version: "0.1.2",
      elixir: "~> 1.0",
      package: package,
      description: "CSV handling library for Elixir." ]
  end

  defp package do
    [ contributors: ["meh"],
      licenses: ["WTFPL"],
      links: %{"GitHub" => "https://github.com/meh/cesso"} ]
  end
end

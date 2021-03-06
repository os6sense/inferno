defmodule Chrysopoeia.Mixfile do
  use Mix.Project

  def project do
    [app: :chrysopoeia,
     version: "0.0.1",
     elixir: "~> 1.1-dev",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.1"},
     {:httpotion, "~> 2.0.0"},
     {:mock, "~> 0.1.0"},
     {:floki, "~> 0.0.5"},
     {:exmerl, "~> 0.1.1"},
     {:eml, "~> 0.7.1"},
     {:zipper_tree, "~>0.1.1"},
     {:exprof, "~>0.2.0"},
    ]
  end
end

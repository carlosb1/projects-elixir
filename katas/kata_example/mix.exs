defmodule KataExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :kata_example,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp escript do
    [main_module: KataBirthday.Run]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mock, "~> 0.3.0", only: :test},
      {:hackney, "~> 1.9"},
      {:swoosh, "~> 1.12"},
      {:gen_smtp, "~> 1.1"}
    ]
  end
end

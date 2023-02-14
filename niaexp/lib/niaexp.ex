defmodule Niaexp do
  @moduledoc """
  Documentation for `Niaexp`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Niaexp.hello()
      :world

  """
  def start do
    ExperimentRunner.start_experiment("nia-experiment.yml")
  end
end

defmodule Spotyhealth do
  @moduledoc """
  Documentation for `Spotyhealth`.
  """

  @doc """
  Get the maximum heart rate

  ## Examples

      iex> Spotyhealth.get_bpm_range_for_exercise_routine(40, :weight_management)
      [108.0, 126.0]

  """
  @spec get_bpm_range_for_exercise_routine(age :: Integer.t, zone :: atom())
    :: Integer.t
  def get_bpm_range_for_exercise_routine(age, zone) do
    with {:ok, maximum_heart_rate} <- get_maximum_heart_rate(age),
     {:ok, [min, max]} <- get_bpm_range_per_zone(zone)
    do
      [
        round_bpm(maximum_heart_rate * min),
        round_bpm(maximum_heart_rate * max)
      ]
    end
  end

  defp get_maximum_heart_rate(age) when is_integer(age) do
    if (age >= 0 && age <= 140) do
      {:ok, 220 - age}
    else
      {:error, :invalid_person_age}
    end
  end
  defp get_maximum_heart_rate(_age), do: {:error, :invalid_person_age}

  defp get_bpm_range_per_zone(zone) do
    case zone do
      z when z == :red_line -> {:ok, [0.9, 1]}
      z when z == :anaerobic_threshold -> {:ok, [0.8, 0.9]}
      z when z == :aerobic -> {:ok, [0.7, 0.8]}
      z when z == :weight_management -> {:ok, [0.6, 0.7]}
      z when z == :healthy_heart -> {:ok, [0.5, 0.6]}
      _ -> {:error, :invalid_zone}
    end
  end

  defp round_bpm(value) when is_float(value), do: Float.round(value)
  defp round_bpm(value), do: value
end

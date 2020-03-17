defmodule SpotyhealthTest do
  use ExUnit.Case
  doctest Spotyhealth

  test "It should return a bpm range between 108 and 126 bpm
    if a 40 years old person wants to lose weight." do
    assert Spotyhealth.get_bpm_range_for_exercise_routine(40, :weight_management) == [108.0, 126.0]
  end

  test "It should return a bpm range between 95 and 114 bpm
    if a 30 years old person wants healthy heart." do
    assert Spotyhealth.get_bpm_range_for_exercise_routine(30, :healthy_heart) == [95.0, 114.0]
  end

  test "It should return an invalid zone error
    if a person specific zone is invalid." do
    assert Spotyhealth.get_bpm_range_for_exercise_routine(30, :invalid_zone) == {:error, :invalid_zone}
  end

  test "It should return an invalid age error
    if a person specific age is invalid." do
    assert Spotyhealth.get_bpm_range_for_exercise_routine(-1, :healthy_heart) == {:error, :invalid_person_age}
  end
end

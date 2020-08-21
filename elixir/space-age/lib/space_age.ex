defmodule SpaceAge do
  @earth_orbit_seconds 31557600

  def age_on(planet, seconds) do
    seconds / planet_orbit_seconds(planet)
  end

  defp planet_orbit_seconds(planet) do
    [
      earth:     1.000000,
      mercury:   0.2408467,
      venus:     0.61519726,
      mars:      1.8808158,
      jupiter:  11.862615,
      saturn:   29.447498,
      uranus:   84.016846,
      neptune: 164.79132
    ][planet] * @earth_orbit_seconds
  end
end

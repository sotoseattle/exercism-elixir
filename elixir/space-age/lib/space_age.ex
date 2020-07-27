defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """

  def orbit(:earth), do: 31557600
  def orbit(:mercury), do: 0.2408467 * orbit(:earth)
  def orbit(:venus), do: 0.61519726 * orbit(:earth)
  def orbit(:mars), do: 1.8808158 * orbit(:earth)
  def orbit(:jupiter), do: 11.862615 * orbit(:earth)
  def orbit(:saturn), do: 29.447498 * orbit(:earth)
  def orbit(:uranus), do: 84.016846 * orbit(:earth)
  def orbit(:neptune), do: 164.79132 * orbit(:earth)

  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds), do: seconds / orbit(planet)
  
end

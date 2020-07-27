defmodule Bob do
  def hey(input) do
    input = String.trim(input)

    cond do
      silent?(input) -> answer(:silence)
      loud_q?(input) -> answer(:loud_q)
      scream?(input) -> answer(:scream)
      asking?(input) -> answer(:question)
      true -> answer(:anything)
    end
  end

  def silent?(input), do: input == ""
  def loud_q?(input), do: scream?(input) && asking?(input)
  def scream?(input), do: input == String.upcase(input) && input =~ ~r/\p{L}/u
  def asking?(input), do: String.last(input) == "?"

  def answer(:silence), do: "Fine. Be that way!"
  def answer(:loud_q), do: "Calm down, I know what I'm doing!"
  def answer(:question), do: "Sure."
  def answer(:scream), do: "Whoa, chill out!"
  def answer(:anything), do: "Whatever."
end

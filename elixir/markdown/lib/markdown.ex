defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @regex_title ~r/(\#+)\s*(.+)$/
  @regex_bold ~r/\_\_(.+)\_\_/
  @regex_ital ~r/\_(.+)\_/
  @regex_list ~r/(<li>.+<\/li>)/

  @spec parse(String.t()) :: String.t()
  def parse(markdown_text) do
    markdown_text
    |> process_line_by_line
    |> process_whole
  end

  defp process_line_by_line(lines) do
    lines
    |> String.split("\n")
    |> Enum.map(&process_line/1)
    |> Enum.join
  end

  defp process_line("#" <> _ = text), do: parse_header(text)
  defp process_line("*" <> _ = text), do: parse_list(text)
  defp process_line(text), do: parse_paragraph(text)

  defp process_whole(text), do: ul_wraper(text)

  defp parse_header(header) do
    [[_, level, text]] = Regex.scan(@regex_title, header)
    h = "h#{String.length(level)}"
    wrap(text, h)
  end

  defp parse_list(text) do
    text
      |> String.trim_leading("* ")
      |> add_format_tags
      |> wrap("li")
  end

  defp parse_paragraph(text) do
    text
    |> add_format_tags
    |> wrap("p")
  end

  defp add_format_tags(text) do
    text
    |> bold_text
    |> ital_text
  end

  defp bold_text(text), do: replacer(text, @regex_bold, "strong")
  defp ital_text(text), do: replacer(text, @regex_ital, "em")
  defp ul_wraper(text), do: replacer(text, @regex_list, "ul")

  defp replacer(texto, regex, tag) do
    Regex.replace(regex, texto, fn _,x -> wrap(x, tag) end)
  end

  defp wrap(something, tag), do: "<#{tag}>#{something}</#{tag}>"
end

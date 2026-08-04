# Render text in color for Markdown / Quarto documents

The `colorize()` function renders text in color for Markdown / Quarto
documents. For documents to be rendered in HTML, it uses a CSS `<span>`;
for documents to be converted to LaTeX and rendered as PDF, it uses
`\textcolor{}{}` from the [`xcolor`](https://ctan.org/pkg/xcolor)
package.

## Usage

``` r
colorize(text, color, format = NULL)

colorize_bg(text, color, format = NULL)
```

## Arguments

- text:

  Text to display, a character string

- color:

  Color to use, a valid color designation; if missing, use `text` as the
  color

- format:

  character specification of the output format. Currently supported
  formats are: `"latex"` (default if
  [`is_latex_output`](https://rdrr.io/pkg/knitr/man/output_type.html)),
  `"html"` (default if
  [`is_html_output`](https://rdrr.io/pkg/knitr/man/output_type.html),
  and `"text"` (otherwise) are supported where the latter just contains
  the input `text` without any color formatting.

## Value

A character string with the input text along with markup for color
encoding.

## Details

A companion function, `colorize_bg()` does the same, but uses the
specified color for the background.

The names of colors Note that a color name not defined in the
[`xcolor`](https://ctan.org/pkg/xcolor) package will trigger a LaTeX
error. e.g., `darkgreen` is not defined but you can use:
`\definecolor{darkgreen}{RGB}{1,50,32}` in a document to be rendered to
PDF.

For inline text, in running text, you can use:

     `r colorize("Gentoo", "orange")` and  `r colorize("Adelie", "purple")` are Penguins.
     The `r colorize("red")` points and the `r colorize("blue")` points are nice

In a chunk, you can also define variables with the names of colors, for
ease of use:

     red <- colorize('red')
     pink <- colorize("pink")
     blue <- colorize('blue')
     green <- colorize("green")
     yellow <- colorize("yellow")
     

Then, these can be used directly in strings, interpolated by
[`glue::glue()`](https://glue.tidyverse.org/reference/glue.html). This
is particularly useful in figure captions.

## Author

Michael Friendly

## Examples

``` r
# show what the generated text looks like when encoded for either HTML or LaTeX
colorize("red", format = "html") |> cat()
#> <span style='color: red;'>red</span>
colorize("red", format = "latex") |> cat()
#> \textcolor{red}{red}

colorize_bg("blue", format = "html") |> cat()
#> <span style='background-color: blue;'>blue</span>
colorize_bg("blue", format = "latex") |> cat()
#> \colorbox{blue}{blue}

# \donttest{
 red <- colorize('red')
 blue <- colorize('blue')
 green <- colorize("green")
 glue::glue("There are {red} points, {blue} points and {green} points")
#> There are red points, blue points and green points
 # }
```

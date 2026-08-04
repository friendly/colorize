# Create a Color Box in a Markdown/Quarto Document

The `colorbox()` function renders text in a colored background for
Markdown / Quarto documents. For documents to be rendered in HTML, ...

## Usage

``` r
colorbox(
  text,
  color = text,
  maincolor = "black",
  bgcolor = "white",
  format = NULL,
  padding = 2
)
```

## Arguments

- text:

  character string with the text to display.

- color:

  R color specification. The default is to use `text`, expecting it to
  be a named color. Beyond this `color` can be any of the three kinds of
  R colors, i.e., either a color name (an element of
  [`colors`](https://rdrr.io/r/grDevices/colors.html)), a hexadecimal
  (hex) string of the form `"#rrggbb"` or `"#rrggbbaa"` (see
  [`rgb`](https://rdrr.io/r/grDevices/rgb.html)), or an integer `i`
  meaning `palette()[i]`. See also
  [`adjust_transparency`](https://colorspace.R-Forge.R-project.org/reference/adjust_transparency.html)
  which is used internally to convert all colors to hex strings of the
  form `"#rrggbb"`.

- maincolor:

  R color specification (see above) for the main text color in the
  Quarto document (default: black).

- bgcolor:

  R color specification (see above) for the background color in the
  Quarto document (default: white).

- format:

  character specification of the output format. Currently, `"latex"`
  (default if
  [`is_latex_output`](https://rdrr.io/pkg/knitr/man/output_type.html)),
  `"html"` (default if
  [`is_html_output`](https://rdrr.io/pkg/knitr/man/output_type.html),
  and `"text"` (otherwise) are supported where the latter just contains
  the input `text` without any color box formatting.

- padding:

  integer. Amount of padding (in pixels) for the color box if
  `format = "html"`.

## Value

A character string with the input text along with markup for a
background color box.

## Details

The function `colorbox()` is a small convenience function that sets up a
color box in LaTeX (via `\colorbox{...}{...}`) or HTML (via
`<span style=...>...</span>`) for a given text. The main convenience is
that the function assesses first whether the text in the color box has a
better contrast when written in the main font color (default: black) or
the background color (default: white). This is decided based on the
`contrast_ratio()` function from the `colorspace` package using the APCA
algorithm.

Additionally, the package canonicalizes all R color specifications to
hex color codes (of the form `#rrggbb`) which can subsequently be
employed easily in both LaTeX and HTML output. The default output format
inside Quarto documents processed via `knitr` is determined using the
functions
[`is_latex_output`](https://rdrr.io/pkg/knitr/man/output_type.html) and
[`is_html_output`](https://rdrr.io/pkg/knitr/man/output_type.html),
respectively.

This illustrates the use of `colorbox()` in a Quarto document:

    I'll be using the penguins data quite a lot, so it is useful to set up custom colors like
    those used in @fig-penguin-species. My versions are shown in @fig-peng-colors with their
    color codes. These are shades of:

    * `r colorbox("Adélie", "orange")`: `r colorbox("orange", "orange")`,
    * `r colorbox("Chinstrap", "purple")`: `r colorbox("purple", "purple")`, and
    * `r colorbox("Gentoo", "green")`: `r colorbox("green", "green")`.

## Author

Achim Zeileis

## Examples

``` r
## basic usage: just supply a color name and let both the background color
## and the output format be decided automatically (the latter does not work
## correctly outside of a quarto/knitr document and hence just returns the text)
colorbox("red")
#> [1] "red"

## emulate behavior in a quarto/knitr document with HTML or LaTeX output
colorbox("red", format = "latex")
#> [1] "\\colorbox[HTML]{FF0000}{\\textcolor[HTML]{FFFFFF}{red}}"
colorbox("red", format = "html")
#> [1] "<span style='background-color: #FF0000; color: #FFFFFF; padding: 2px'>red</span>"

## instead of fully saturated red in sRGB, employ other flavors of red:
## - color 2 in R's default palette
## - color #D55E00 from the Okabe-Ito palette
colorbox("red", color = 2, format = "html")
#> [1] "<span style='background-color: #DF536B; color: #FFFFFF; padding: 2px'>red</span>"
colorbox("red", color = "#D55E00", format = "html")
#> [1] "<span style='background-color: #D55E00; color: #FFFFFF; padding: 2px'>red</span>"

## by default, either black or white is used for the text color
## (which ever has the better contrast) but alternatively a different
## main font color (say gray10) and a different background color (say cornsilk)
## can be used for the text
colorbox("red", color = 2, maincolor = "gray10", bgcolor = "cornsilk", format = "html")
#> [1] "<span style='background-color: #DF536B; color: #FFF8DC; padding: 2px'>red</span>"
colorbox("yellow", color = 7, maincolor = "gray10", bgcolor = "cornsilk", format = "html")
#> [1] "<span style='background-color: #F5C710; color: #1A1A1A; padding: 2px'>yellow</span>"
```

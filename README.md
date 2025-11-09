
<!-- README.md is generated from README.Rmd. Please edit that file -->

# colorize

**Version 0.0.1**

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The `colorize` package provides some simple functions for printing text
in color in markdown or Quarto documents, to be rendered as HTML or
LaTeX.

This is useful when writing about the use of colors in graphs or tables,
where you want to print their names in their actual color to give a
direct impression of the color, like “red” shown in
<span style="color: red;">red</span>, or “blue” shown in
<span style="color: blue;">blue</span>. This is similar to the use of
*direct labels* in graphs, which are perceptually bound closely to what
is portrayed, rather than an *indirect legend*, which takes more
cognitive energy to see what data in referred to in the graph.

The following functions are provided:

- `colorize(text, color)`: Print the `text` in a given `color`, as in
  <span style="color: red;">this text in red</span>
- `colorize_bg(text, color)`: Print the `text` with a background in
  `color`, as in <span style="background-color: red;">this text in
  red</span>
- `colorbox(text, color, ...)`: Print `text` with background in color,
  but where the text is given a contrasting color designed to be most
  legible, as in
  <span style="background-color: #FF0000; color: #FFFFFF; padding: 2px">this
  text in red</span>

In the examples above, note the difference between `colorize_bg()` and
`colorbox()`: when the desired color is
<span style="color: red;">red</span>, `colorbox()` uses a lighter color
(white) so the text contrasts more with the darker background.

This is somewhat similar to what RStudio does when you enter color names
or hex values in code, but `colorbox()` uses
`colorspace::contrast_ratio(textcolor, color, ...)` to find the
`textcolor` that **contrasts best** against the background `color`.

![](man/figures/test_colors.png)

## Installation

You can install the development version of colorize like so:

``` r
remotes::install.github("friendly/colorize")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(colorize)
## basic example code
```

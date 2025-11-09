
<!-- README.md is generated from README.Rmd. Please edit that file -->

# colorize

<!-- badges: start -->

<!-- badges: end -->

The `colorize` package provides some simple functions for printing text
in color in markdown or Quarto documents, to be rendered as HTML or
LaTeX.

This is useful when writing about the use of colors in graphs or tables,
where you want to print their names in their actual color to give a
direct impression of the color, like “red” shown in
<span style="color: red;">red</span>, or “blue” shown in
<span style="color: blue;">blue</span>. This is similar to the use of
**direct labels** in graphs, which are perceptually bound to what is
portrayed, rather than an indirect legend, which takes more cognitive
energy.

The following functions are provided:

- `colorize(text, color)`: Print the `text` in a given `color`
- `colorize_bg(text, color)`: Print the `text` with a background in
  `color`
- `colorbox(text, color, ...)`: Print `text` with bacground in color,
  but where the text is given a contrasting color designed to be most
  legible.

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

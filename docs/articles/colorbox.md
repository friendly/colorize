# Printing Text in Color in Markdown / Quarto

The colorize package provides some simple functions for printing text in
color in markdown or Quarto documents, to be rendered as HTML or LaTeX.
This is useful when writing about the use of colors in graphs or tables,
where you want to print their names in their actual color to give a
direct impression of the color, like “red” shown in red, or “blue” shown
in blue.

The following functions are provided:

- `colorize(text, color)`: Print the `text` in a given `color`, as in
  this text in red
- `colorize_bg(text, color)`: Print the `text` with a background in
  `color`, as in this text in red
- `colorbox(text, color, ...)`: Print `text` with background in color,
  but where the text is given a contrasting color designed to be most
  legible, as in this text in red

### Normal usage

In text describing analysis of the `penguins` data, to match the colors
used in a graph, you can simply use the functions like so

```` markdown
```{r}
#| eval: false
`r colorize("Gentoo", "orange")` and  `r colorize("Adelie", "purple")` and  
`r colorize("Chinstrap", "darkgreen")` are Penguins.

This plot has `r colorize("red")` points, `r colorize("blue")` points, 
`r colorize("green")` points, which are nice!
Other colors used in the plot are `r colorize("yellow")`, `r colorize("pink")`, 
`r colorize("gray")` and `r colorize("black")`.

As you can see, `r colorize("yellow")` and `r colorize("pink")` are illegible on a white background,
but `r colorbox("yellow")` and `r colorbox("pink")` work fine.
```
````

This renders as:

Gentoo and Adelie and Chinstrap are Penguins.

This plot has red points, blue points, green points, which are nice!
Other colors used in the plot are yellow, pink, gray and black.

As you can see, yellow and pink are illegible on a white background, but
in a
[`colorbox()`](http://friendly.github.io/colorize/reference/colorbox.md),
yellow and pink work fine.

### Named colors

*Idea:* Named colors can just be included via
[`colorbox()`](http://friendly.github.io/colorize/reference/colorbox.md)
with just their name, e.g., `colorbox("red")` for red.

*Examples:* black, gray, red, orange, yellow, green, blue, cyan,
magenta, pink, darkgreen, purple.

[`colorize()`](http://friendly.github.io/colorize/reference/colorize.md)
simply prints the color name in that color

*Examples*: black, gray, red, orange, yellow, green, blue, cyan,
magenta, pink, darkgreen, purple.

### LaTeX color names

You must be careful with LaTeX output. Quarto and markdown typically use
the [`xcolor` package](https://ctan.org/pkg/xcolor). This does not
define all the color names available in R or HTML and so will trigger
LaTeX errors if a color name is undefined.

For example, `darkgreen` is not defined there, but you can use:
`\definecolor{darkgreen}{RGB}{1,50,32}` in a document to be rendered to
PDF.

### Hex colors

*Idea:* Hex colors can be included via
[`colorbox()`](http://friendly.github.io/colorize/reference/colorbox.md)
using two arguments, their verbal description (or text to be printed)
and the precise hex color code, e.g.,
`colorbox("bluishgreen", "#009E73")` for bluishgreen.

*Examples:* The Okabe-Ito palette as provided (by default) by
`grDevices::palette.colors(names = TRUE)` has following elements,

``` r
oi <- palette.colors(names = TRUE) |>
  print()
```

            black        orange       skyblue   bluishgreen        yellow
        "#000000"     "#E69F00"     "#56B4E9"     "#009E73"     "#F0E442"
             blue    vermillion reddishpurple          gray
        "#0072B2"     "#D55E00"     "#CC79A7"     "#999999" 

Rendering each of these as
[`colorbox()`](http://friendly.github.io/colorize/reference/colorbox.md),
using their names (`names(oi)[i]`) and values (`oi[i]`) gives:

black, orange, skyblue, bluishgreen, yellow, blue, vermillion,
reddishpurple, gray.

### Defining color variables in your document

If you want to more easily use colorized color names in your document,
in a chunk somewhere you can simply create them as variables, whichever
of
[`colorize()`](http://friendly.github.io/colorize/reference/colorize.md),
`color_bg()` or
[`colorbox()`](http://friendly.github.io/colorize/reference/colorbox.md)
suits your needs. For example:

``` r
red <- colorize('red')
pink <- colorize("pink")
blue <- colorize('blue')
green <- colorize("green")
yellow <- colorize("yellow")
lightgreen <- colorize("lightgreen")
darkgreen <- colorize("darkgreen")
```

Then, you can use them directly in text as [inline
code](https://quarto.org/docs/computations/inline-code.html) (r code,
enclosed in backticks), giving “this line is red”, “that point is blue”.

You can also use these with
[`glue::glue()`](https://glue.tidyverse.org/reference/glue.html) more
simply as “this line is {red}, this point is {blue}”, which interpolates
their values into a string.

I use this to create colorized text in figure captions, where, in
Quarto, it is necessary to use `!expr` to have the text of the caption
evaluated:

```` markdown
```{r}
#| eval: false
#| label: fig-Salaries-loess
#| fig-cap: !expr glue::glue("Scatterplot of Salary vs. years since PhD, adding the loess smooth. 
#|    The loess smooth curve and confidence band in {green} is nearly indistinguishable 
#|    from a quadratic fit in {blue}.")

gg1 + 
  geom_smooth(method = "loess", formula = "y ~ x", 
              color = "blue", fill = scales::muted("blue"),
              linewidth = 2) +
  geom_smooth(method = "lm", formula = "y ~ x", se = FALSE,
              color = "red",
              linewidth = 2) +
  geom_smooth(method = "lm", formula = "y ~ poly(x,2)", 
              color = "darkgreen", fill = "lightgreen",
              linewidth = 2) 
```
````

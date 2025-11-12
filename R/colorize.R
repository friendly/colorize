#' Render text in color for Markdown / Quarto documents
#'
#' The `colorize()` function renders text in color for Markdown / Quarto documents. For documents to be rendered in HTML,
#' it uses a CSS `<span>`; for documents to be converted to LaTeX and rendered as PDF, it
#' uses `\textcolor{}{}` from the [`xcolor`](https://ctan.org/pkg/xcolor) package.
#' A companion function, `colorize_bg()` does the same, but uses the specified color for the background.
#'
#' @details
#'
#' The names of colors
#' Note that a color name not defined in the `xcolor` package will trigger a LaTeX error.
#' e.g., `darkgreen` is not defined but you can use:
#'    `\definecolor{darkgreen}{RGB}{1,50,32}` in a document to be rendered to PDF.
#'
#' For inline text, in running text, you can use:
#'
#' ```
#'  `r colorize("Gentoo", "orange")` and  `r colorize("Adelie", "purple")` are Penguins.
#'  The `r colorize("red")` points and the `r colorize("blue")` points are nice
#' ```
#'
#'  In a chunk, you can also define variables with the names of colors, for ease of use:
#'
#'  \preformatted{
#'  red <- colorize('red')
#'  pink <- colorize("pink")
#'  blue <- colorize('blue')
#'  green <- colorize("green")
#'  yellow <- colorize("yellow")
#'  lightgreen <- colorize("lightgreen")
#'  darkgreen <- colorize("darkgreen")
#'  brown <- colorize("brown", "brown4")
#'  }
#'
#'
#' @param text  Text to display, a character string
#' @param color Color to use, a valid color designation; if missing, use `text` as the color
#'
#' @author Michael Friendly
#' @return A character string with color-encoded text
#' @export
#'
#' @examples
#' \donttest{
#'  red <- colorize('red')
#'  blue <- colorize('blue')
#'  green <- colorize("green")
#'  glue::glue("There are {red} points, {blue} points and {green} points")
#'  }
#'
colorize <- function(text, color) {
  if (missing(color)) color <- text
  if (knitr::is_latex_output()) {
    sprintf("\\textcolor{%s}{%s}", color, text)
  } else if (knitr::is_html_output()) {
    sprintf("<span style='color: %s;'>%s</span>", color, text)
  } else text      # Fallback for other formats
}

# Define some color names for use in figure captions.
# use as:
#    #| fig-cap: !expr glue::glue("Some points are {red}, some are  {blue}, some are {green}")

# perhaps better to color the background
#' @rdname colorize
#' @export
colorize_bg <- function(text, color) {
  if (missing(bgcolor)) bgcolor <- text
  if (knitr::is_latex_output()) {
    sprintf("\\colorbox{%s}{%s}", color, text)
  } else if (knitr::is_html_output()) {
    sprintf("<span style='background-color: %s;'>%s</span>", bgcolor, text)
  } else {
    text # Fallback for other formats
  }
}


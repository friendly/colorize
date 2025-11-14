#' Render text in color for Markdown / Quarto documents
#'
#' The `colorize()` function renders text in color for Markdown / Quarto documents. For documents to be rendered in HTML,
#' it uses a CSS `<span>`; for documents to be converted to LaTeX and rendered as PDF, it
#' uses `\textcolor{}{}` from the [`xcolor`](https://ctan.org/pkg/xcolor) package.
#'
#' A companion function, `colorize_bg()` does the same, but uses the specified color for the background.
#'
#' @details
#'
#' The names of colors
#' Note that a color name not defined in the [`xcolor`](https://ctan.org/pkg/xcolor) package will trigger a LaTeX error.
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
#'  }
#'
#'  Then, these can be used directly in strings, interpolated by `glue::glue()`. This is particularly useful in figure captions.
#'
#'
#' @param text  Text to display, a character string
#' @param color Color to use, a valid color designation; if missing, use `text` as the color
#' @param format character specification of the output format. Currently supported formats are:
#' \code{"latex"} (default if \code{\link[knitr]{is_latex_output}}),
#' \code{"html"} (default if \code{\link[knitr]{is_html_output}},
#' and \code{"text"} (otherwise) are supported where the latter just contains
#' the input \code{text} without any color formatting.
#'
#' @author Michael Friendly
#' @return A character string with the input text along with markup for color encoding.
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
colorize <- function(text,
                     color,
                     format) {
  if (missing(color)) color <- text

  # determine output format
  if (is.null(format)) format <- if (is_latex_output()) "latex" else if (is_html_output()) "html" else "text"
  format <- match.arg(tolower(format), c("latex", "html", "text"))

  switch(format,
    "latex" = sprintf("\\textcolor{%s}{%s}", color, text),
    "html" = ssprintf("<span style='color: %s;'>%s</span>", color, text),
    "text" = text)

  # if (knitr::is_latex_output()) {
  #   sprintf("\\textcolor{%s}{%s}", color, text)
  # } else if (knitr::is_html_output()) {
  #   sprintf("<span style='color: %s;'>%s</span>", color, text)
  # } else text      # Fallback for other formats
}


#' @rdname colorize
#' @export
colorize_bg <- function(text,
                        color,
                        format) {
  if (missing(color)) color <- text

  # determine output format
  if (is.null(format)) format <- if (is_latex_output()) "latex" else if (is_html_output()) "html" else "text"
  format <- match.arg(tolower(format), c("latex", "html", "text"))

    if (knitr::is_latex_output()) {
    sprintf("\\colorbox{%s}{%s}", color, text)
  } else if (knitr::is_html_output()) {
    sprintf("<span style='background-color: %s;'>%s</span>", bgcolor, text)
  } else {
    text # Fallback for other formats
  }
}


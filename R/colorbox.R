#  colorbox
#
# Requires:
#
#           \makeatletter
#           \newcommand{\globalcolor}[1]{%
#             \color{#1}\global\let\default@color\current@color
#           }
#           \makeatother
#           \definecolor{textgray}{HTML}{212529}
#           \globalcolor{textgray}
#
# TODO:
#  Describe the setting for `textcolor`

#' Create a colorbox in a Markdown / Quarto Document
#'
#' The `colorbox()` function renders text in a colored colored background for Markdown / Quarto documents. For documents to be
#' rendered in HTML, ...
#'
#' @details
#'
#' This illustrates the use of `colorbox()` in a Quarto document:
#'
#' ````
#' I'll be using the penguins data quite a lot, so it is useful to set up custom colors like those
#' used in @fig-penguin-species. My versions are shown in @fig-peng-colors with their color codes. These are shades of:
#'
#' * `r colorbox("Adélie", "orange")`: `r colorbox("orange", "orange")`,
#' * `r colorbox("Chinstrap", "purple")`: `r colorbox("purple", "purple")`, and
#' * `r colorbox("Gentoo", "green")`: `r colorbox("green", "green")`.
#' ````
#'
#' This is the result, rendered to HTML
#'
#' ![Penguin colors](man/figures/colorbox-penguins.jpg)
#'
#' **LaTeX**
#'
#' For LaTeX output to be rendered to PDF, this assumes the standard package `xcolor`. In addition, `colorbox()` requires the additonal
#' definitions (defining `gray`) to be made available in your document (e.g., in a `preamble.tex` file or in the `yml` header).
#' In this, you should change `212529` to the hex value for the main font used in your document. In R, this is closest to the
#' named color `gray13`. For "black", use `000000`.
#'
#' ```
#'   \makeatletter
#'      \newcommand{\globalcolor}[1]{%
#'        \color{#1}\global\let\default@color\current@color
#'      }
#'      \makeatother
#'        \definecolor{textgray}{HTML}{212529}
#'        \globalcolor{textgray}
#' ```
#'
#'
#' @param text    Text to display, a character string
#' @param desired background color (e.g., `"red"` or `"#DF536B"`)
#' @param maincolor main text color in document
#' @param bgcolor   background color in document (default: "white")
#'
#' @returns A character string with color-encoded text
#' @author Achim Zeileis
#' @export
#'
#' @examples
#' # placeholder for better examples
#' colorbox("Gentoo", "green")
colorbox <- function(text,
                     color = text,
                     maincolor = "#212529",
                     bgcolor = "white") {
  ## Arguments:
  ## - text: character string
  ## - color: desired background color (e.g., red or #DF536B)
  ## - maincolor: main text color in document
  ## - bgcolor: background color in document

  ## determine whether `maincolor` or `bgcolor` have a higher contrast
  ## when they are the text color and `color` is the background color
  textcolor <- c(maincolor, bgcolor)
  textcolor <- textcolor[which.max(abs(colorspace::contrast_ratio(textcolor, color, algorithm = "APCA")[, "normal"]))]

  ## canonicalize to hex codes without hashtag and alpha channel
  color <- colorspace::adjust_transparency(c(color, textcolor), alpha = FALSE)
  color <- gsub("#", "", color, fixed = TRUE)

  ## set up formatted string
  if (knitr::is_latex_output()) {
    sprintf("\\colorbox[HTML]{%s}{\\textcolor[HTML]{%s}{%s}}", color[1L], color[2L], text)
  } else if (knitr::is_html_output()) {
    sprintf("<span style='background-color: #%s; color: #%s; padding: 2px'>%s</span>", color[1L], color[2L], text)
  } else {
    text
  }
}

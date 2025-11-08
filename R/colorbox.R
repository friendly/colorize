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

#' Create a colorbox in a Markdown / Quarto Document
#'
#' @param text    Text to display, a character string
#' @param desired background color (e.g., `"red"` or `"#DF536B"`)
#' @param maincolor main text color in document
#' @param bgcolor   background color in document (default: "white")
#'
#' @returns
#' @export
#'
#' @examples
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

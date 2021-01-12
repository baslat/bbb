#' Morph the format of a bounding box
#'
#' Change the layout and names of a bounding box. The function will figure out
#' the current layout of your bounding box and morph it to the desired output
#' style.
#'
#' @param bbox a bounding box
#' @param output_type (quoted character) the desired output format. One of
#'   \code{"xy_string"}, \code{"word_string"} or \code{"xy_matrix"}.
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' bbox <- c("left" = -73.848849, "bottom" = -40.979898, "right" = -28.11848, "top" = 0.703107)
#' attr(bbox, "class") <- "bbox"
#' bbox2 <- morph(bbox, "xy_string")
#' }
#'
#'
morph <- function(bbox,
                  output_type) {
  # Check for dplyr
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop(glue::glue('You need `dplyr` to run this function. Try installing it with:
                    install.packages("dplyr")'))
  }
  # Input assertions
  stopifnot(class(bbox) == "bbox")
  stopifnot(output_type %in% c("xy_string", "word_string", "xy_matrix"))

  # Determine input type ----
  n <- length(bbox)
  words <- any(names(bbox) == "left")
  xy <- any(names(bbox) == "xmax")

  input_type <- dplyr::case_when(
    words == TRUE && n == 4 ~ "word_string",
    xy == TRUE && n == 4 ~ "xy_string",
    TRUE ~ "other"
  )

  # Early return if no change needed
  if (input_type == output_type) {
    return(bbox)
  }
  # Check for valid input format
  if (input_type == "other") {
    stop("This input type is not yet implemented.")
  }


  # Determine the final function and apply it ----
  func <- switch(output_type,
                 "xy_string" = "word_str_to_xy_str",
                 "word_string" = "xy_str_to_word_str")

  fun_raw <- glue::glue("{func}(bbox)")
  eval(parse(text = fun_raw))

}


#' Morph a word string bbox to a xy string bbox
#'
#' Changes the format of a word string bounding box (ie left, right etc) to an
#' xy string type (eg xmax, ymin).
#'
#' @param bbox A bounding box with names left, right etc
#'
#' @return a bounding box uses \code{xmax} etc style as a string
#'
word_str_to_xy_str <- function(bbox) {
  names(bbox) <- c("xmin", "ymin", "xmax", "ymax")
  return(bbox)
}


#' Morph a xy string bbox to a word string bbox
#'
#' Changes the format of a xy string bounding box (eg xmax, ymin) to an
#' word string type (ie left, right etc).
#'
#' @param bbox A bounding box with names left, right etc
#'
#' @return a bounding box uses \code{xmax} etc style as a string
#'
xy_str_to_word_str <- function(bbox) {
  names(bbox) <- c("left", "bottom", "right", "top")
  return(bbox)
}

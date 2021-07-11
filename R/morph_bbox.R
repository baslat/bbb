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
#' @return a bounding box in the desired format
#' @export
#'
#' @examples
#' \dontrun{
#' bbox <- c("left" = -73.848849, "bottom" = -40.979898, "right" = -28.11848, "top" = 0.703107)
#' attr(bbox, "class") <- "bbox"
#' bbox2 <- morph(bbox, "xy_string")
#' }
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

  bbox_ws <- to_word_str(bbox) # nolint

  # Determine the final function and apply it ----
  func <- switch(output_type, # nolint
    "word_string" = "to_word_str",
    "xy_string" = "word_str_to_xy_str",
    "xy_matrix" = "word_str_to_xy_matrix"
  )

  fun_raw <- glue::glue("{func}(bbox_ws)")
  eval(parse(text = fun_raw))
}

#' Morph any bounding box to a word string bounding box
#'
#' Take any bounding box format and morph it to a word string type.
#'
#' @param bbox a bounding box
#'
#' @return a word string bounding box
#'
to_word_str <- function(bbox) {

  # If a matrix
  if (any(class(unclass(bbox)) == "matrix")) {
    bb <- c("left" = bbox[1, 1], "bottom" = bbox[2, 1], "right" = bbox[1, 2], "top" = bbox[2, 2])
    attr(bb, "class") <- "bbox"
    attr(bb, "crs") <- attr(bbox, "crs")
    return(bb)
  } else {
    names(bbox) <- c("left", "bottom", "right", "top")
    return(bbox)
  }
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


#' Morph an xy string bbox to a xy matrix bbox
#'
#' Changes the format of a xy string bounding box (eg xmax, ymin) to an
#' xy matrix type.
#'
#' @param bbox A bounding box with names xmin, ymax etc
#'
#' @return a bounding box in matrix form
#'
word_str_to_xy_matrix <- function(bbox) {
  bb <- rbind(c(bbox["left"], bbox["right"]), c(bbox["bottom"], bbox["top"]))
  dimnames(bb) <- list(c("x", "y"), c("min", "max"))
  attr(bb, "class") <- "bbox"
  attr(bb, "crs") <- attr(bbox, "crs")
  return(bb)
}

#' Get the code to reproduce your bounding box
#'
#' Provides the code to reproduce your bounding box.
#'
#' @param mbb a manual bounding box from \code{manual_bbox}
#'
code_bbox <- function(mbb) {
  bb_code <- glue::glue(
    'bbox <- c("left" = {mbb[1,1]}, "bottom" = {mbb[2,1]}, "right" = {mbb[1,2]}, "top" = {mbb[2,2]})
    attr(bbox, "class") <- "bbox"')
  rstudioapi::insertText(text = bb_code)
  invisible()
}

#' Manually build a bounding box using the Shiny rectangle
#'
#' Manually construct the bounding box and return a vector.
#'
#' @param coords from the shiny
#'
#' @return a matrix
manual_bbox <- function(coords) {
  # the + 360 is probably not always valid
  left <- coords[[1]][[1]]
  right <- coords[[3]][[1]]
  bottom <- coords[[1]][[2]]
  top <- coords[[3]][[2]]
  bb <- rbind(c(left, right), c(bottom, top))
  dimnames(bb) <- list(c("x", "y"), c("min", "max"))
  attr(bb, "class") = "bbox"
  return(bb)
}





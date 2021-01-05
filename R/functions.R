#' Convert a drawn box to an SF object
#'
#' Take a rectangle drawn on the leaflet, pull out its coords, and turn it into
#' a single feature polygon
#'
#' @param coords from the shiny, the list of coords
#'
#' @return an sf object
#'
box_to_sf <- function(coords) {

  # Create a sfg polygon
  pts <- coords %>%
    purrr::map(unlist) %>%
    purrr::reduce(rbind)
  # Adjust for the >180 coords
  pts <- ifelse(abs(pts) > 180,
                pts + 360, pts)
  rownames(pts) <- NULL

  # Make an sf object
  sf::st_polygon(list(pts)) %>%
    # sf::st_sfc(crs = 3857)
    sf::st_sfc(crs = "+proj=longlat +datum=WGS84")
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
  x_min <- coords[[1]][[1]]
  x_max <- coords[[3]][[1]]
  y_min <- coords[[1]][[2]]
  y_max <- coords[[3]][[2]]
  bb <- rbind(c(x_min, x_max), c(y_min, y_max))
  dimnames(bb) <- list(c("x", "y"), c("min", "max"))
  attr(bb, "class") = "bbox"
  return(bb)
}


#' Get the code to reproduce your bounding box
#'
#' Provides the code to reproduce your boudning box.
#'
#' @param mbb a manual bounding box from \code{manual_bbox}
#'
code_bbox <- function(mbb) {
  bb_code <- glue::glue(
    'box <- c("xmin" = {mbb[1,2]}, "ymin" = {mbb[2,1]}, "xmax" = {mbb[1,2]}, "ymax" = {mbb[2,2]})
    attr(box, "class") = "bbox"')
  rstudioapi::insertText(text = bb_code)
  invisible()
}



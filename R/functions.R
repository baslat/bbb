#' Get the code to reproduce your bounding box
#'
#' Provides the code to reproduce your bounding box.
#'
#' @param mbb a manual bounding box from \code{manual_bbox}
#'
code_bbox <- function(mbb) {
  bb_code <- glue::glue(
			'bbox <- sf::st_bbox(c("xmin" = {mbb[["xmin"]]}, "ymin" = {mbb[["ymin"]]}, "xmax" = {mbb[["xmax"]]}, "ymax" = {mbb[["ymax"]]}), crs = 4326L)'
		)
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
  xmin <- coords[[1L]][[1L]]
		xmax <- coords[[3L]][[1L]]
		ymin <- coords[[1L]][[2L]]
		ymax <- coords[[3L]][[2L]]

		sf::st_bbox(
			c(
				"xmin" = xmin,
				"ymin" = ymin,
				"xmax" = xmax,
				"ymax" = ymax
			),
			crs = 4326L
		)
}

test_that("morph_bbox works", {
  bbox <- c("left" = 149.727208, "bottom" = -35.491984, "right" = 149.86187, "top" = -35.404722)
  attr(bbox, "class") <- "bbox"
  attr(bbox, "crs") <- sf::st_crs(3857)


  outs <- c("xy_matrix",
            "xy_string",
            "word_string")

  boxes <- purrr::map(outs,
                      bbb::morph,
                      bbox = bbox)

  boxes %>%
    purrr::map(~expect_true(class(.) == "bbox"))


  atts <- boxes %>%
    purrr::map(attributes)

  x <- atts %>%
    purrr::map(magrittr::use_series,
               "crs")

  expect_equal(x[[1]], x[[2]])
  expect_equal(x[[2]], x[[3]])
})

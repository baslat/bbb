#' Build a bounding box
#'
#' Launches an interactive \code{shiny} session for you to draw a bounding box.
#' The code to recreate the bounding box is then available in your script.
#'
#' @export
#'
box <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::titlePanel(title = "Build a bounding box"),
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          shiny::h3("Use:"),
          shiny::tags$ol(
            shiny::tags$li("Draw a bounding box using the ",
                    shiny::strong("square"),
                    "button on the map."),
            shiny::tags$li("Click the ",
                    shiny::code("build my box"),
                    "button to create the code needed to reproduce that bounding
                    box")),
          shiny::actionButton(inputId = "button",
                              label = "Build my box")),
      shiny::mainPanel(
        leaflet::leafletOutput(outputId = "map")
        )
      )
    ),
    server = function(input, output) {
      output$map = leaflet::renderLeaflet({
        leaflet::leaflet() %>%
          leaflet::setView(lng = 0,
                           lat = 0,
                           zoom = 1) %>%
          leaflet::addTiles() %>%
          leaflet.extras::addDrawToolbar(
            singleFeature = TRUE,
            polylineOptions = FALSE,
            polygonOptions = FALSE,
            circleOptions = FALSE,
            markerOptions = FALSE,
            circleMarkerOptions = FALSE
          ) %>%
          leaflet.extras::addSearchOSM()

      })

      shiny::observeEvent(input$button, {
        req(input$map_draw_all_features)
        coords <- input$map_draw_all_features$features[[1]]$geometry$coordinates[[1]]
        # Turn into a bounding box
        mbb <- manual_bbox(coords)
        # Write the code to make the bbox
        message(glue::glue("Save the below code in your script to make a reproducible bbox."))
        code_bbox(mbb = mbb)
        shiny::stopApp()
        # }
      })
    }
  )
}

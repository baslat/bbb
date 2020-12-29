app <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(shiny::actionButton("button",
                                              "Build my box"),
                          leaflet::leafletOutput('map')
                          ),

    server = function(input, output) {
      output$map = leaflet::renderLeaflet({
        leaflet::leaflet() %>%
          leaflet::addTiles() %>%
          leaflet.extras::addDrawToolbar(
            singleFeature = TRUE,
            polylineOptions = FALSE,
            polygonOptions = FALSE,
            circleOptions = FALSE,
            markerOptions = FALSE,
            circleMarkerOptions = FALSE
          )

      })

      shiny::observeEvent(input$button, {
        test <<- input$map_draw_all_features$features[[1]]
      })
    }
  )
}

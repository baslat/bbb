app <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::titlePanel(title = "Bounding Box Builder"),
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          shiny::textInput(inputId = "var_name",
                           label = "Name of the bb var",
                           value = "bbox"),
          shiny::actionButton(inputId = "button",
                              label = "Build my box")
          ),
      shiny::mainPanel(
        leaflet::leafletOutput(outputId = "map")
        )
      )
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
        # Get the coords from the box
        coords <- input$map_draw_all_features$features[[1]]$geometry$coordinates[[1]]
        # Turn into an sf
        box <- box_to_sf(coords)
        # Assign to something in the global
        # Need to add check that var_name exists
        assign(x = input$var_name,
               value = box,
               envir = .GlobalEnv)
        shiny::stopApp()
      })
    }
  )
}

#' Build a bounding box
#'
#' Launches an interactive \code{shiny} session for you to draw a bounding box.
#' The code to create the bounding box is then available in your script, or an
#' object can be created in your session, or both.
#'
#' @export
#'
box <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      shiny::titlePanel(title = "Bounding Box Builder"),
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          shiny::h2("Use:"),
          shiny::p("Draw a bounding box using the 'square' button on the map. Click the"),
          shiny::code("build my box"),
          shiny::p("button to create the code needed to reproduce that bounding
                   box"),
          # shiny::p("as well as an `sf` rectangle in the global environment."),
          # shiny::textInput(inputId = "var_name",
          #                  label = "Name of the bb var",
          #                  value = "bbox_sf"),
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
        # Check if a box is drawn

        # if (exists("input$map_draw_all_features")) {
          # Get the coords from the box
          coords <- input$map_draw_all_features$features[[1]]$geometry$coordinates[[1]]

          # Turn into an sf
          box <- box_to_sf(coords)
          mbb <- manual_bbox(coords)
          # Assign to something in the global
          # Need to add check that var_name exists
          # assign(x = input$var_name,
          #        value = box,
          #        envir = .GlobalEnv)
          # # testing ---
          # assign(x = "mbb",
          #        value = mbb,
          #        envir = .GlobalEnv)
          # assign(x = "coords",
          #        value = coords,
          #        envir = .GlobalEnv)
          # Write the code to make the bbox
          glue::glue(#"An sf object called `{input$var_name}` is now in your global environment.
                     #It's a rectangle from which you can extract a bounding box with `sf::st_bbox`.
                     "Save the below code in your script to make a reproducible bbox.") %>%
            message()
          code_bbox(mbb = mbb)

          shiny::stopApp()
        # }

      })
    }
  )
}

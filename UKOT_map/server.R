##################################
############# Server #############
##################################

function(input, output, session) {
  # preventing shinyapp in heroku greying out after idle timeout limit 55 secs passed
  # https://stackoverflow.com/questions/54594781/how-to-prevent-a-shiny-app-from-being-grayed-out
  autoInvalidate <- reactiveTimer(10000)
  observe({
    autoInvalidate()
    cat('.')
  })
  

  ###### Custom markers ----
  
 marker_selected <-
      makeIcon (iconUrl = "https://tghn2.github.io/UKOT-PHN_map/markers/Icon-Marker_Selected.png",
                iconWidth = 22,
                iconHeight = 22,
                iconAnchorX = 11,
                iconAnchorY = 22
      )
    
marker_sidebar <-
      makeIcon (iconUrl = "https://tghn2.github.io/UKOT-PHN_map/markers/Icon-Marker_Selected-wSideBar.png",
                iconWidth = 24,
                iconHeight = 32.2642
      )


  #### Build map ----
  
  createMap <- function()
  {
    hide("loading")
    
    output$mymap <- renderLeaflet({
      leaflet(CountryDetails) %>%
        setView(0, 0, zoom = 2) %>%
        addTiles(
          urlTemplate = "https://tghn2.github.io/UKOT-PHN_map/tiles/{z}/{x}/{y}.png",
          attribution = '&copy; <a href="© map designed by <a href="https://www.improperagency.com/">IMPROPER Agency</a> for <a href="https://ukot-phn.tghn.org/">UKOT-PHN</a> | Coded by <a href="https://tghn.org/">TGHN Digital</a>',
          options = tileOptions(
            tms = FALSE,
            minZoom = 0,
            maxZoom = 6,
            continuousWorld = FALSE,
            noWrap = TRUE
          )
        ) %>%
      
        
        ## Add markers
        addCircleMarkers(
          radius = 10,
          color = "#E40046",
          stroke = FALSE,
          fillOpacity = 1,
          lng = ~lng,
          lat = ~lat,
          popup = ~paste(
              "<div class='leaflet-popup-scrolled' style='max-width:240px;max-height:300px;border:0px;padding:2px;'><span style='font-family: proxima nova, noto sans, helvetica, arial, sans-serif; font-size: 18pt; line-height: 20pt; color: #003B5C;'>",
              Territory, "</span><br>",
              "<span style='font-family: proxima nova, noto sans, helvetica, arial, sans-serif; font-size: 12pt; font-weight: light; line-height: 14pt;'>", Location, "</span>", "<p style='font-family: proxima nova, noto sans, helvetica, arial, sans-serif; font-size: 11pt'>",
              "<b>Hemisphere: </b>", Hemisphere, "<br>",
              "<b>Island(s)/Non-Island: </b>", Islands, "<br>",
              "<b>Size: </b>", Size, "</p>",
              "<p style='font-family: proxima nova, noto sans, helvetica, arial, sans-serif; font-size: 11pt'>",
              "<b>Population: </b>", Populations, "<br>",
              "<b>Main Language: </b>", Language, "</p>",
              "<p>",
              # action button here: Read More, when on click, side panel on the right side comes up with more information about the territory from the data set + infographics
              actionButton(inputId = "modal", label =  "Read More", style = "text-align: center; background-color: #E40046; color: #FFFFFF; font-weight: bold; border-radius:3px; border:0; padding: 4px;", opacity = 1, onclick = 'Shiny.setInputValue(\"button_click\", this.id, {priority: \"event\"})'),
              "</p>",
              "</div>"
            )

          )



      # would like to add hover function where the marker changes to the selectedMarker defined in the icon list.
        
    })
  }

  ###### Modal Dialogue for Action Button in PopUp ----

  observeEvent(input$button_click, {
  
    clicked_point <- reactiveVal(input$mymap_CircleMarker_click)
    showModal(modalDialog(
      title = "Work in Progress",
      size = "s",
      easyClose = TRUE,
      fade = TRUE,
      footer = NULL,
    ))
  })


  #### Marker Change on Mouse over ----
  
  createMap()
  
  ############## Reset button ----
  observeEvent(input$reset_app, {
    js$reset_app()
  })
}
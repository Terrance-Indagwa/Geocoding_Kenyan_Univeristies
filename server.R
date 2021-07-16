source("common.R")

shinyServer({

function(input, output, session){


  content <- as.character(paste(sep = "<br/>",
                                " Name:",full_base_geos$name,
                                " Year chartered:",full_base_geos$`year chartered`,
                                " Original name:",full_base_geos$`original name`,
                                " Campus:",full_base_geos$campus,
                                " Address:",full_base_geos$address
  ))

  # Interactive leaf

  output$leaf <- renderLeaflet({



    leaf <- leaflet(data = full_base_geos) %>%
      addTiles() %>%
      addProviderTiles(provider = providers$Esri.NatGeoWorldleaf) %>%
      addMarkers(lng = ~lon, lat = ~lat, label = ~htmlEscape(name),
                 labelOptions = labelOptions(noHide = FALSE, textsize = "10px"),
                 popup = content, popupOptions = popupOptions(closeButton = FALSE, maxWidth = 100, closeOnClick = TRUE))

    leaf


  })


  # A reactive expression that returns the current institution that is in bound


  currentInbound <- reactive({
    if(is.null(input$leaf_bounds))
      return(full_base_geos[FALSE,])

    bounds <- input$leaf_bounds

    latRng <- range(bounds$north, bounds$south)
    lonRng <- range(bounds$east, bounds$west)

    subset(full_base_geos,
           lat>=latRng[1] & lat<=latRng[2]&
             lon>=lonRng[1]&lon<=lonRng[2])
  })


  observe({
    if (is.null(input$goto))
      return()
    isolate({
      leaf <- leafletProxy("leaf")
      leaf %>% clearPopups()

      name <- input$goto$name
      lat <- input$goto$lat
      lon <- input$goto$lon

      leaf %>% fitBounds(currentInbound())



    })
  })

  output$Data <- DT::renderDataTable({
    df <- full_base_geos %>%
      filter(
        `year chartered` == input$year_chartered | name == input$Name
      ) %>%
      mutate(Action = paste('<a class="go-leaf" href="" data-lat="', lat, '" data-lon="', lon,'" data-name"', name, '"><i class="fa fa-crosshairs"></i></a>', sep=""))
    action <- DT::dataTableAjax(session, df, outputId = "Data")

    DT::datatable(df, options = list(ajax = list(url = action)), escape = FALSE)
  })




}



















})

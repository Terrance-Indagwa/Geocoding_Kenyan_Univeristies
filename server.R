source("common.R")

shinyServer({

function(input, output, session){


  output$leaf <- renderLeaflet({

    content <- as.character(paste(sep = "<br/>",
                                  " Name:",full_base_geos$name,
                                  " Year chartered:",full_base_geos$`year chartered`,
                                  " Original name:",full_base_geos$`original name`,
                                  " Campus:",full_base_geos$campus,
                                  " Address:",full_base_geos$address
    ))


    leaf <- leaflet(data = full_base_geos) %>%
      addTiles() %>%
      addProviderTiles(provider = providers$Esri.NatGeoWorldMap) %>%
      addMarkers(lng = ~lon, lat = ~lat, label = ~htmlEscape(name),
                 labelOptions = labelOptions(noHide = FALSE, textsize = "10px"),
                 popup = content, popupOptions = popupOptions(closeButton = FALSE, maxWidth = 100, closeOnClick = TRUE))

    leaf


  })

output$data <- renderDataTable(full_base_geos)

}



















})

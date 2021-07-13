
source("common.R")


header <- dashboardHeader(
  title = "KENYA HIGHER INSTITUTIONS"
)

sidebar <- dashboardSidebar(
  collapsed = FALSE,
  sidebarMenu(
    menuItem(
      text = "Overview",
      tabName = "overview",
      icon = icon("book")
    ),
    menuItem(
      text = "Institutions geo-locations",
      tabName = "geo_locations",
      icon = icon("globe")
    ),
    menuItem(
      text = "Data",
      tabName = "Data",
      icon = icon("book")
    ),
    menuItem("Source Code", icon = icon("file-code-o"),
             href = "https://github.com/Terrance-Indagwa/Geocoding_Kenyan_Univeristies/")
  ),
  sidebarUserPanel(
    div(style="font-family:Sans-serif",
      name = "Indagwa Musur Terrance",
                   subtitle = "Founder: Rwills Statistical Consultancy")
)
)
body <- dashboardBody(


  tabItems(


    tabItem(
      tabName = "overview",
      fluidPage(
        h2(tags$b("Brief summary")),
        br(),
        div(style = "text-align:justify",
            p("Kenya is a fast growing country from East Africa, She has invested heavily in setting up instutions of higher learning most of them having backgrounds in STEM or Technical education lines.",
              "There are: `r sum(full_base_geos$category=='public')` public universities, `r sum(full_base_geos$category=='private')` private universities and `r sum(full_base_geos$category=='other')` major colleges in the country"),
            br()
        )
      )
    ),

    # TAB 2

    tabItem(
      tabName = "geo_locations",
      fluidPage(
        box(width = 12,
            solidHeader = T,
            h3(tags$b("Institutions geo-locations")),
            leafletOutput("leaf", height = 530))

      )
    ),

    # TAB 3

    tabItem(
      tabName = "Data",
      h2(tags$b("Data used")),
      dataTableOutput("data")
    )
  )
)

# Combining Dashboard Part
dashboardPage(
  header = header,
  body = body,
  sidebar = sidebar,
  skin = "green"
)


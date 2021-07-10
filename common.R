#packages
p_required <- c("tidyverse", "ggthemes", "leaflet","shiny","shinydashboard", "plotly","htmltools")
packages <- rownames(installed.packages())
p_to_install <- p_required[!(p_required %in% packages)]
if (length(p_to_install) > 0) {
  install.packages(p_to_install)
}
sapply(p_required, require, character.only = TRUE)
library(shinydashboard)
rm(p_required, p_to_install, packages)


# readng in the data
full_base_geos<- read_csv("full_base_geos.csv")


# Popup informations

#popup <- content <- paste(sep = "<br/>",
    #                      "<b><a href='http://www."full_base_geos$name.ac.ke">" #full_base_geos$name"</a></b>",
#                          full_base_geos$category,
#                          full_base_geos$`year chartered`
#)

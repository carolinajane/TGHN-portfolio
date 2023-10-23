#################################
#### Libraries and functions ####
#################################

library(leaflet)
library(shinyjs)
library(shinyBS)
library(shinydashboard)
library(shinycssloaders)
library(readr)
library(htmltools)
library(htmlwidgets)

#### Shinyjs reset code ----

jsResetCode <- "shinyjs.reset_app = function() {history.go(0)}"

#### Load country details ----

CountryDetails <- read_csv("./data/CountryDetails.csv")



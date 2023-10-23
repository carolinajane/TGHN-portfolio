#################################
############### UI ##############
#################################

tagList(
  includeCSS("./www/style.css"),
  useShinyjs(),
  shinyjs::extendShinyjs(text = jsResetCode, functions = "reset_app"),
  dashboardPage(
    dashboardHeader(disable = TRUE),
    dashboardSidebar(disable = TRUE),
    dashboardBody(tags$head(tags$style(
      HTML("
           .content-wrapper {background-color: #ffffff;
        }
           "
           )
    )
    
    ),
    
    #### map loading row ----
    div(id = 'loading',
        fluidRow(column(
          12, h3("Please wait a moment while the map initializes...")
        ))),
    
    # Create a new row for the map ----
    fluidRow(leafletOutput("mymap", width="900px", height="500px") %>% withSpinner(color = "#272f38"))
    
    )
  )
)
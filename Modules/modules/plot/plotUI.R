#
#Esta funcao cria a interface plot
#
createPlotUI = function(){
  
  mainPanel(
    tags$b("Your data:"),
    DT::dataTableOutput("tbl"),
    br(),
    uiOutput("data"),
    br(),
    tags$b("Compute parameters by hand:"),
    uiOutput("by_hand"),
    br(),
    tags$b("Compute parameters in R:"),
    verbatimTextOutput("summary"),
    br(),
    tags$b("Regression plot:"),
    uiOutput("results"),
    plotlyOutput("plot"),
    br(),
    tags$b("Interpretation:"),
    uiOutput("interpretation"),
    br(),
    br()
  )
  
}
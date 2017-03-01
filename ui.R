library(shiny)
library(shinydashboard)
require(rCharts)
library(shinythemes)
require(quantmod)
require(rCharts)
require(latticeExtra)
require(Lahman) ; require(plyr); library(ascii); library(shiny); library(ggplot2)

ui <- fluidPage( theme=shinytheme("slate"),
                 
                 fluidRow(
                   
                   tabBox(
                     title = "Statistics",
                     # the height and width of the tab box is similar to the space 
                     #available for us on the xbox app
                     id = "Tabs", height = "600px",width = "9",
                     tabPanel("Summary",
                              
                              fluidRow(
                                column(width=12,br(),
                                       wellPanel(fluidRow(column(12,offset=0,valueBoxOutput(width=2,"Kills"),
                                                                 valueBoxOutput(width=2,"Deaths"),
                                                                 valueBoxOutput(width=2,"Assists"),
                                                                 valueBoxOutput(width=2,"KperD"),
                                                                 valueBoxOutput(width=2,"KAperD"),
                                                                 valueBoxOutput(width=2,"KperG"),
                                                                 valueBoxOutput(width=2,"SpartanRank"), 
                                                                 valueBoxOutput(width=2,"WinRate"),
                                                                 valueBoxOutput(width=2,"Headshot"),
                                                                 valueBoxOutput(width=2,"Accuracy"),
                                                                 valueBoxOutput(width=2,"GamesPlayed"),
                                                                 valueBoxOutput(width=2,"TimePlayed")))
                                       ))
                                
                                
                              ),
                              
                              
                              fluidRow(column(width=12,wellPanel(fluidRow(column(1,offset=0,showOutput("Display123", "Highcharts")), 
                                                                          column(3,offset=8,checkboxGroupInput("variable", "Select Statistic to Display:",
                                                                                    c("Kills" = "cyl",
                                                                                      "Deaths" = "am",
                                                                                      "Assists" = "gear")))),
                                                                
                                                                  fluidRow(column(5,offset =2, sliderInput("Slider", "Match",min = 1, max = 20, value = c(5, 15))))
                                      
                                       )))
                              
                              
                              
                              
                             
                              
                              
                     ),
                     #screen1 ends
                     
                     
                     tabPanel("Relative", fluidRow(column(3,selectInput("varRelStat", label = "Choose a Statistic:", 
                                                                        choices = c("Kills","Deaths","Assists"))),
                                                   
                                                   column(2,showOutput("RelativePlot1","Highcharts")),
                                                   
                                                   column(1,offset=5,checkboxGroupInput("varFriends", "Friends:",
                                                                                        c("Medha" = "Medha",
                                                                                          "Nikita" = "Nikita")))),
                              
                              fluidRow(column(5,offset=4,sliderInput("varMatchRange", 
                                                                     label = NULL,
                                                                     min = 1, max = 25, value = c(1, 25))))),
                     tabPanel("Predictive",   
                              sidebarLayout(
                       # Sidebar with a slider and selection inputs
                       sidebarPanel(
                         selectInput("selection", "Choose a statistic:",
                                     choices = list(
                                       "Kills",
                                       "Deaths",
                                       "Assists")),
                         
                         
                         sliderInput("max",
                                     "Number of hours played/week:",
                                     min = 0,  max = 168,  value = 0)
                       ),
                       
                       # Show Graph
                       mainPanel(
                         showOutput("PredictiveChart","highcharts")
                       )
                     )),
                     tabPanel("Heat Maps", 
                              
                              fluidRow(column(4,titlePanel("Heat Maps"))),
                              
                              fluidRow(column(3,selectInput("map", "Maps:", c(#"Orion",
                                #"Pegasus",
                                #"Coliseum",
                                "Fathom",
                                "Empire"
                                #"Mercy"
                                # "Eden" = "eden",
                                #"Plaza" = "plaza",
                                #"The Rig" = "therig",
                                # "Torque" = "torque",
                                # "Truth" = "truth",
                                # "Tyrant" = "tyrant",
                                # "Regret" = "regret",
                                # "Altitude" = "altitude",
                                # "Crossfire" = "crossfire",
                                # "Gambol" = "gambol",
                                # "Trench" = "trench",
                                # "Trident" = "trident"
                              ),width="80%"),br(),br(),
                              selectInput("stat", "Statistics:", c("Kills" = "k", 
                                                                   "Assists" = "a",
                                                                   "Deaths" = "d"),width="80%"),
                              sliderInput("time", "Range of Observations",
                                          min = 1, max = 1000, value = c(1,1000),width="80%")
                              
                              
                              ),
                              column(9,
                                     
                                     
                                     showOutput("myChart","highcharts")
                              )
                              
                              
                              
                              )),
                     tabPanel("Esports", "tab5")
                   )
                 )
)


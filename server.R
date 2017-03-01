dat <- read.csv("data.csv")  
dat2 <- read.csv("C:\\Users\\Mahin\\Downloads\\data2.csv")  
PID <- dat$PID


medhaData <- read.csv("heatmaps.csv")
mydf <- data.frame(medhaData)

server = function(input, output){
  
  output$Kills <- renderValueBox({
    valueBox(value = tags$p("Kills", style = "font-size: 80%;"),
             subtitle = tags$p(paste0(dat$Kills), style = "font-size: 100%;"))
  })
  
  output$Deaths <- renderValueBox({
    valueBox(value = tags$p("Deaths", style = "font-size: 80%;"),
             subtitle = tags$p(paste0(dat$Deaths), style = "font-size: 100%;"))
  })
  
  output$Assists <- renderValueBox({
    valueBox(value = tags$p("Assists", style = "font-size: 80%;"),
             subtitle = tags$p(paste0(dat$Assists), style = "font-size: 100%;"))
  })
  
  output$KperD <- renderValueBox({
    valueBox( value = tags$p("K/D", style = "font-size: 80%;"),
              subtitle = tags$p(paste0("6.34","%"), style = "font-size: 100%;"))
  })
  
  output$KAperD <- renderValueBox({
    valueBox(value = tags$p("(K+A)/D", style = "font-size: 80%;"),
             subtitle = tags$p(paste0("4.34","%"), style = "font-size: 100%;"))
  })
  
  output$KperG <- renderValueBox({
    valueBox(value = tags$p("K/G", style = "font-size: 80%;"),
             subtitle = tags$p(paste0("6.74","%"), style = "font-size: 100%;"))
  })
  
  output$SpartanRank <- renderValueBox({
    valueBox(value = tags$p("Spartan Rank", style = "font-size: 80%;"),
             subtitle = tags$p(paste0("148","%"), style = "font-size: 100%;"))
  })
  
  output$WinRate <- renderValueBox({
    valueBox(value = tags$p("Win%", style = "font-size: 80%;"),
             subtitle = tags$p(paste0("7.89","%"), style = "font-size: 100%;"))
  })
  
  output$Headshot <- renderValueBox({
    valueBox(value = tags$p("Headshot%", style = "font-size: 80%;"),
             subtitle = tags$p(paste0("6.89","%"), style = "font-size: 100%;"))
  })
  
  output$Accuracy <- renderValueBox({
    valueBox(value = tags$p("Accuracy %", style = "font-size: 80%;"),
             subtitle = tags$p(paste0("6.89","%"), style = "font-size: 100%;"))
  })
  
  output$GamesPlayed <- renderValueBox({
    valueBox(value = tags$p("Games Played", style = "font-size: 80%;"),
             subtitle = tags$p(paste0("1456"), style = "font-size: 100%;"))
  })  
  
  output$TimePlayed <- renderValueBox({
    valueBox(value = tags$p("Time Played", style = "font-size: 80%;"),
             subtitle = tags$p(paste0("145:34:23"), style = "font-size: 100%;"))
  })  
  

  
  output$Display123 <- renderChart2({
    h1 <- Highcharts$new()
    h1$chart(type = "spline")
    h1$series(data = dat$KperD, name="K/D",color="purple", dashStyle = "longdash")
    h1$series(data =  dat$KAperD, name="K+A/D", color="brown",dashStyle = "shortdot")
    h1$series(data =  dat$KperG, name="K/G",color="red", dashStyle = "shortdot")
    h1$legend(symbolWidth = 10)
    h1$params$width <- 650
    h1$params$height <- 400
    h1$title(text = "K/D, K+A/D & K/G")
    h1$chart(backgroundColor="#C1C1C1")
    return(h1)
  })
  
#heatmaps
  output$myChart <- renderChart2({
    img_src <-'\\maps\\empire.jpg'
    if (input$map == "Empire")
    {
      img_src <- '\\maps\\empire.png'
      p <- Highcharts$new()
      p$chart(type='scatter', plotBackgroundImage=img_src)
      p$data(x = mydf$X,y = mydf$Y, marker = list(fillColor = 'blue'))
      
      p$xAxis(min = 0,max = 5)
      
      p$addParams(dom='chart')
      p$params$width <- "60%"
      p$params$height <- "80%"
      p$params$showAxes <- FALSE
      
      return(p)
    }
    
    if (input$map == "Fathom")
    {
      img_src <- '\\maps\\fathom.png'
      p <- Highcharts$new()
      p$chart(type='scatter', plotBackgroundImage=img_src)
      p$data(x = mydf$X,y = mydf$Y, marker = list(fillColor = 'blue'))
      
      p$xAxis(min = 0,max = 5)
      
      p$addParams(dom='chart')
      p$params$width <- "60%"
      p$params$height <- "80%"
      p$params$showAxes <- FALSE
      
      return(p)
    }
  })
  
  #predictive
  
  output$PredictiveChart <- renderChart2({
    h1 <- Highcharts$new()
    h1$chart(type = "spline")
    h1$series(data = c(1, 3, 2, 4, 5, 4, 6, 2, 3, 5, NA), dashStyle = "longdash")
    h1$series(data = c(NA, 4, 1, 3, 4, 2, 9, 1, 2, 3, 4), dashStyle = "shortdot")
    h1$legend(symbolWidth = 80)
    return(h1)
  } )
  
  output$RelativePlot1 <-renderChart2({  
    
    
    if (input$varRelStat=="Kills"){
      
      
      if (length(input$varFriends)=='0')
      {
        output$RelativePlot1 <-renderChart2({
          
          
          h1 <- Highcharts$new()
          h1$chart(type = "spline")
          h1$series(data = dat$Kills, name="Kills",color="green", dashStyle = "longdash")
          
          h1$legend(symbolWidth = 80)
          h1$chart(height = 350) 
          h1$chart(width = 500)
          h1$title(text = input$varRelStat)
          return(h1) })
      }
      else if (length(input$varFriends)=='1'){
        
        output$RelativePlot1 <-renderChart2({
          
          h1 <- Highcharts$new()
          h1$chart(type = "spline")
          h1$series(data = dat$Kills, name="Kills",color="blue", dashStyle = "longdash")
          h1$series(data = dat$Kills2, name="Kills2",color="orange", dashStyle = "longdash")
          h1$legend(symbolWidth = 80)
          h1$chart(height = 350) 
          h1$chart(width = 500)
          h1$title(text = input$varRelStat)
          return(h1) })
      }
      else if (length(input$varFriends)>'1'){
        output$RelativePlot1 <-renderChart2({
          
          h1 <- Highcharts$new()
          h1$chart(type = "spline")
          h1$series(data = dat$Kills, name="Kills",color="blue", dashStyle = "longdash")
          h1$series(data = dat$Kills2, name="Kills2",color="orange", dashStyle = "longdash")
          h1$series(data = dat$Kills3, name="Kills3",color="purple", dashStyle = "longdash")
          h1$legend(symbolWidth = 80)
          h1$chart(height = 350) 
          h1$chart(width = 500)
          h1$title(text = input$varRelStat)
          return(h1) })
      }
      
    }
    
    
    if (input$varRelStat=="Deaths"){
      if (length(input$varFriends)==0)
      {
        output$RelativePlot1 <-renderChart2({
          
          h2 <- Highcharts$new()
          h2$chart(type = "spline")
          h2$series(data =  dat$Deaths, name="Deaths", color="orange",dashStyle = "shortdot")
          h2$legend(symbolWidth = 80)
          h2$chart(height = 350)
          h2$chart(width = 500)
          h2$title(text = input$varRelStat)
          return(h2) })
      }
      else if (length(input$varFriends)==1){
        output$RelativePlot1 <-renderChart2({
          
          h1 <- Highcharts$new()
          h1$chart(type = "spline")
          h1$series(data =  dat$Deaths, name="Deaths", color="orange",dashStyle = "shortdot")
          h1$series(data =  dat$Deaths2, name="Deaths", color="purple",dashStyle = "shortdot")
          h1$legend(symbolWidth = 80)
          h1$chart(height = 350)
          h1$chart(width = 500)
          h1$title(text = input$varRelStat)
          return(h1) })
      }
      else if (length(input$varFriends)>1){
        output$RelativePlot1 <-renderChart2({
          
          h1 <- Highcharts$new()
          h1$chart(type = "spline")
          h1$series(data =  dat$Deaths, name="Deaths", color="orange",dashStyle = "shortdot")
          h1$series(data =  dat$Deaths2, name="Deaths", color="purple",dashStyle = "shortdot")
          h1$series(data =  dat$Deaths3, name="Deaths", color="red",dashStyle = "shortdot")
          h1$legend(symbolWidth = 80)
          h1$chart(height = 350)
          h1$chart(width = 500)
          h1$title(text = input$varRelStat)
          return(h1) })
      }
    }
    if (input$varRelStat=="Assists"){
      if (length(input$varFriends)==0)
      { output$RelativePlot1 <-renderChart2({
        
        
        h1 <- Highcharts$new()
        h1$chart(type = "spline")
        h1$series(data =  dat$Assists, name="Assists",color="red", dashStyle = "shortdot")
        h1$legend(symbolWidth = 80)
        h1$chart(height = 350)
        h1$chart(width = 500)
        h1$title(text = input$varRelStat)
        return(h1) })
      }
      else if (length(input$varFriends)==1){
        output$RelativePlot1 <-renderChart2({
          
          h1 <- Highcharts$new()
          h1$chart(type = "spline")
          h1$series(data =  dat$Assists, name="Assists",color="red", dashStyle = "shortdot")
          h1$series(data =  dat$Assists2, name="Assists",color="purple", dashStyle = "shortdot")
          h1$legend(symbolWidth = 80)
          h1$chart(height = 350)
          h1$chart(width = 500)
          h1$title(text = input$varRelStat)
          return(h1) })
      }
      
      else if (length(input$varFriends)>1){
        output$RelativePlot1 <-renderChart2({
          
          h1 <- Highcharts$new()
          h1$chart(type = "spline")
          h1$series(data =  dat$Assists, name="Assists",color="red", dashStyle = "shortdot")
          h1$series(data =  dat$Assists2, name="Assists",color="purple", dashStyle = "shortdot")
          h1$series(data =  dat$Assists3, name="Assists",color="purple", dashStyle = "shortdot")
          h1$legend(symbolWidth = 80)
          h1$chart(height = 350)
          h1$chart(width = 500)
          h1$title(text = input$varRelStat)
          return(h1) })
      }
      
      
    }
    
  })
  
}
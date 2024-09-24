# 필요한 패키지 로드
library(shiny)
library(ggplot2)

# UI 정의
ui <- fluidPage(
  titlePanel("Box Plot Example"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("gear", "Select Number of Gears:",
                  choices = unique(mtcars$gear),
                  selected = unique(mtcars$gear)[1])
    ),
    
    mainPanel(
      plotOutput("boxPlot")
    )
  )
)

# 서버 로직 정의
server <- function(input, output) {
  output$boxPlot <- renderPlot({
    filtered_data <- mtcars[mtcars$gear == input$gear, ]
    
    ggplot(filtered_data, aes(x = factor(gear), y = mpg)) +
      geom_boxplot(fill = "lightblue") +
      labs(title = paste("Box Plot of MPG for", input$gear, "Gears"),
           x = "Number of Gears",
           y = "Miles Per Gallon (MPG)")
  })
}

# Shiny 앱 실행
shinyApp(ui = ui, server = server)

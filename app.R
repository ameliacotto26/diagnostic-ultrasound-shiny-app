library(shiny)
library(tidyverse)

maude <- read_csv("maude_ultrasound_2025_final.csv")
recalls <- read_csv("fda_ultrasound_recalls_2025_final.csv")

ui <- navbarPage(
  "Diagnostic Ultrasound Dashboard",
  
  tabPanel(
    "MAUDE Events",
    
    p("Explore 2025 MAUDE adverse event reports for diagnostic ultrasound devices."),
    
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "device_type",
          "Choose a Device Type:",
          choices = c(
            "All",
            sort(unique(maude$device_type))
          )
        )
      ),
      
      mainPanel(
        plotOutput("maude_plot"),
        tableOutput("maude_table")
      )
    )
  ),
  
  tabPanel(
    "FDA Recalls",
    
    p("Explore 2025 FDA ultrasound recalls by device type and root cause."),
    
    sidebarLayout(
      sidebarPanel(
        selectInput(
          "recall_device",
          "Choose a Device Type:",
          choices = c(
            "All",
            sort(unique(recalls$device_type))
          )
        )
      ),
      
      mainPanel(
        plotOutput("recall_plot"),
        tableOutput("recall_table")
      )
    )
  )
)

server <- function(input, output) {maude_filtered <- reactive({
  if (input$device_type == "All") {
    maude
  } else {
    maude %>%
      filter(device_type == input$device_type)
  }
})

output$maude_plot <- renderPlot({
  maude_filtered() %>%
    count(event_type) %>%
    ggplot(aes(x = event_type, y = n, fill = event_type)) +
    geom_col() +
    labs(
      title = "2025 MAUDE Events",
      x = "Event Type",
      y = "Number of Reports"
    ) +
    theme_minimal() +
    theme(legend.position = "none")
})
  
  output$maude_table <- renderTable({
    maude_filtered() %>%
      count(event_type) %>%
      arrange(desc(n))
  })

  
recalls_filtered <- reactive({
  if (input$recall_device == "All") {
    recalls
  } else {
    recalls %>%
      filter(device_type == input$recall_device)
  }
})

output$recall_plot <- renderPlot({
  recalls_filtered() %>%
    count(root_cause_description) %>%
    ggplot(aes(x = reorder(root_cause_description, n), y = n,
               fill = root_cause_description)) +
    geom_col() +
    coord_flip() +
    labs(
      title = "2025 FDA Ultrasound Recalls",
      x = "Root Cause",
      y = "Number of Recalls"
    ) +
    theme_minimal() +
    theme(legend.position = "none")
})

output$recall_table <- renderTable({
  recalls_filtered() %>%
    count(root_cause_description) %>%
    arrange(desc(n))
})

}

shinyApp(ui = ui, server = server)
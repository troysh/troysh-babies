library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Exploring the Babies Datasset from UsingR"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(h2("Introduction"),
   p("This app allows you to test for associations in the babies data set",
    "which is derived from the Child and Health Development Study"),
   p("The chi-squared test is used to test for associations between categorical variables.",
    "We turn continuous data into categorical variables for this demonstration."),
    h2("Variable Selection"),
   p(selectInput("v1", "First variable",
  choices=c("Weight (oz)", "Length of Gestation", "Mother's Race", 'Previous births', 'Smoke'), 
    selected="Weight (oz)")),
   p(selectInput("v2", "Second variable",
  choices=c("Weight (oz)", "Length of Gestation", "Mother's Race", 'Previous births', 'Smoke'), 
    selected="Mother's Race"))

 )

  ,
  mainPanel(h2("Results: ", textOutput('v1',inline=T)," vs ",textOutput('v2',inline=T)),
    verbatimTextOutput('sum'),
    p( verbatimTextOutput('min')),
    p(a(href="https://dl.dropboxusercontent.com/u/6256411/babies/index.html", "Project pitch!"))
  )

)))


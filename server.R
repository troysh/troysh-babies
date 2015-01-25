library(shiny)
library(UsingR) 
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  dataset <- function(name) {
  r <- NULL
  if (name=='Weight (oz)')  {
    r<-babies$wt
    r<-ifelse(r==999,NA,r)
    q <- quantile(r, c(.25,.5,.75,1), na.rm=T)
    r<-cut(r, q)
  }
  if (name=="Mother's Race")   {
    race <- babies$race
    r <- ifelse(race >=0 & race<=5, 'White', 
      ifelse(race==6, 'Mexican',
        ifelse(race==7, 'Black',
          ifelse(race==8, 'Asian',
            ifelse(race==9, 'Mixed', NA)))))    
  }
  if (name=="Length of Gestation")   {
    r<- babies$gestation
    r<- ifelse(r==999, NA, r)
    q <- quantile(r, c(.25,.5,.75,1), na.rm=T)
    r<-cut(r, q)
  }
  if (name=='Previous births')   
    r <- ifelse(babies$parity==0, '0',
         ifelse(babies$parity==1, '1',
         ifelse(babies$parity==2, '2', '3+')))
  if (name=='Smoke')
    r <- ifelse(babies$smoke==0, 'No',
    	 ifelse(babies$smoke==1, 'Current',
         ifelse(babies$smoke==2, 'Until Pregnancy',
         ifelse(babies$smoke==3, "Previously", NA))))
  #cat(paste(r,"\n"))
  r
  }
  gets1 <- reactive({ dataset(input$v1) })
  gets2 <- reactive({ dataset(input$v2) })
  output$sum <- renderPrint({
    var1 <- gets1()
    #cat(paste(length(s1),"\n"))
    var2 <- gets2()
    #cat(paste(length(s2),"\n"))
    print(table(var1,var2))
    chisq.test(var1,var2)
    #
    #str(s1)
    #str(s2)
  })
  output$min <- renderText({
    s1 <- gets1()
    s2 <- gets2()
    ct <- chisq.test(s1,s2)
    paste('The minimum expected value is ',
    min(ct$expected),',  This should be at least five for the test to be valid.',
    ' With a p value of ',ifelse(ct$p.value>=.005,round(ct$p.value,2),'<0.01'),
    ' this test shows ',ifelse(ct$p.value>.05,'no ',''),
    'evidence of association between ',input$v1,' and ',input$v2,
    sep='')
  })
  output$v1 <- renderText({input$v1})
  output$v2 <- renderText({input$v2})
})


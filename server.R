library(shiny)
library(ggplot2)
library(Cairo)

plotbinom = function(x, n, test)
{
  plotdata = data.frame(x=0:n, y=dbinom(0:n, n, as.numeric(test)), pval=0:n >= x)
  ggplot(plotdata, aes(x=x, y=y, fill=factor(pval))) + geom_area() + labs(x="Binomial Distribution", y="Probability", title="Difference Test Plot") + guides(fill="none") + scale_fill_manual(values = c("FALSE" = "gray20", "TRUE" = "deeppink")) + scale_x_continuous(limits = c(0, n)) +
  theme_minimal()
  
}

plotbinomsim = function(x, n, pd, test)
{
  pmax = (pd/100)+(as.numeric(test)*(1-(pd/100)))
  plotdata = data.frame(x=0:n, y=dbinom(0:n, n, pmax), pval=0:n >= x)
  ggplot(plotdata, aes(x=x, y=y, fill=factor(pval))) + geom_area() + labs(x="Binomial Distribution", y="Probability", title="Similarity Test Plot") + guides(fill="none") + scale_fill_manual(values = c("FALSE" = "gray20", "TRUE" = "deeppink")) + scale_x_continuous(limits = c(0, n)) +
    theme_minimal()
  
}


shinyServer(function(input, output){
  output$nullplot = renderPlot({plotbinom(input$x, input$n, as.numeric(input$test))})
  
  output$nullplotsim = renderPlot({plotbinomsim(input$x, input$n, input$pd, as.numeric(input$test))})
  
  output$pvalue = renderText({paste("Exact p-value = ", format(pbinom(input$x-1, input$n, as.numeric(input$test), FALSE), digits=3), sep="")})
  
  output$pvaluesim = renderText({paste("Exact p-value = ", format(1-pbinom(input$x-1, input$n, (input$pd/100)+(as.numeric(input$test)*(1-(input$pd/100))), FALSE), digits=3), sep="")})
  
  
  output$power = renderText({paste("Power = ", format(pbinom(input$x-1, input$n, (input$pd/100)+(as.numeric(input$test)*(1-(input$pd/100))), FALSE), digits=3), sep="")})


  
  output$explan = renderText({paste(input$x," or more correct responses is evidence of a difference at the alpha = ", format(pbinom(input$x-1, input$n, as.numeric(input$test), FALSE), digits=3)," level of significance.", sep="")})
  
  output$explansim = renderText({paste(input$x-1," or fewer correct responses indicates that you can be ", format(100*pbinom(input$x-1, input$n, (input$pd/100)+(as.numeric(input$test)*(1-(input$pd/100))), FALSE)),"% sure that no more than ", input$pd, "% of panelists can detect a difference.", "(beta = ", format(1-pbinom(input$x-1, input$n, (input$pd/100)+(as.numeric(input$test)*(1-(input$pd/100))), FALSE)), ")",   sep="")})
  
  
  
  
})
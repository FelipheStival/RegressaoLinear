#
#Service plot
#
plotService = function(input,output,session,dataPlot){
  
  #criando pagina
  output$mainPanel = renderUI({
    
    if(!is.null(dataPlot())){
      
      #visualizar dados
      output$tbl = DT::renderDataTable({
        dataPlot()
      })
      
      #Visualizacao data
      output$data <- renderUI({
        
        x = NULL
        y = NULL
        if(!is.null(input$arquivoUpload) & length(names(dataPlot())) > 1){
          
          x = dataPlot()[,input$arquivoEixoX]
          y = dataPlot()[,input$arquivoEixoY]
          
        } else
        {
          y = extract(input$y)
          x = extract(input$x)  
        }
        
        if (anyNA(x) | length(x) < 2 | anyNA(y) | length(y) < 2) {
          "Invalid input or not enough observations"
        } else if (length(x) != length(y)) {
          MENSAGEM_TAMANHO_INPUT_ERRO
        } else {
          withMathJax(
            paste0("\\(\\bar{x} =\\) ", round(mean(x), 3)),
            br(),
            paste0("\\(\\bar{y} =\\) ", round(mean(y), 3)),
            br(),
            paste0("\\(n =\\) ", length(x))
          )
        }
      })
      
      #Parametros computados a mao
      output$by_hand <- renderUI({
        y <- extract(input$y)
        x <- extract(input$x)
        fit <- lm(y ~ x)
        withMathJax(
          paste0("\\(\\hat{\\beta}_1 = \\dfrac{\\big(\\sum^n_{i = 1} x_i y_i \\big) - n \\bar{x} \\bar{y}}{\\sum^n_{i = 1} (x_i - \\bar{x})^2} = \\) ", round(fit$coef[[2]], 3)),
          br(),
          paste0("\\(\\hat{\\beta}_0 = \\bar{y} - \\hat{\\beta}_1 \\bar{x} = \\) ", round(fit$coef[[1]], 3)),
          br(),
          br(),
          paste0("\\( \\Rightarrow y = \\hat{\\beta}_0 + \\hat{\\beta}_1 x = \\) ", round(fit$coef[[1]], 3), " + ", round(fit$coef[[2]], 3), "\\( x \\)")
        )
      })
      
      #Sumario
      output$summary <- renderPrint({
        y <- extract(input$y)
        x <- extract(input$x)
        fit <- lm(y ~ x)
        summary(fit)
      })
      
      #grafico
      output$plot <- renderPlotly({
        y <- extract(input$y)
        x <- extract(input$x)
        fit <- lm(y ~ x)
        dat <- data.frame(x, y)
        p <- ggplot(dat, aes(x = x, y = y)) +
          geom_point() +
          stat_smooth(method = "lm", se = input$se) +
          ylab(input$ylab) +
          xlab(input$xlab) +
          theme_minimal()
        ggplotly(p)
      })
      
      #interpretacao
      output$interpretation <- renderUI({
        y <- extract(input$y)
        x <- extract(input$x)
        fit <- lm(y ~ x)
        
        if(exists("fit")){
          
          if (summary(fit)$coefficients[1, 4] < 0.05 & summary(fit)$coefficients[2, 4] < 0.05) {
            withMathJax(
              paste0(MENSAGEM_FIXA_INTERPRETACAO),
              br(),
              paste0("Para um valor (hipotético) o", input$xlab, " = 0,a média de ", input$ylab, " = ", round(fit$coef[[1]], 3), "."),
              br(),
              paste0("Por um aumento de uma unidade de", input$xlab, ", ", input$ylab, ifelse(round(fit$coef[[2]], 3) >= 0,"aumenta (em media) em","diminui (em media) em"), abs(round(fit$coef[[2]], 3)), ifelse(abs(round(fit$coef[[2]], 3)) >= 2, " units", " unit"), ".")
            )
          } else if (summary(fit)$coefficients[1, 4] < 0.05 & summary(fit)$coefficients[2, 4] >= 0.05) {
            withMathJax(
              paste0(MENSAGEM_FIXA_INTERPRETACAO),
              br(),
              paste0("Para um valor (hipotético) de", input$xlab, " = 0,a média de ", input$ylab, " = ", round(fit$coef[[1]], 3), "."),
              br(),
              paste0("\\( \\beta_1 \\)", " nao e significativamente diferente de 0 (p-value = ", round(summary(fit)$coefficients[2, 4], 3), ") entao nao ha relacao significativa entre", input$xlab, " and ", input$ylab, ".")
            )
          } else if (summary(fit)$coefficients[1, 4] >= 0.05 & summary(fit)$coefficients[2, 4] < 0.05) {
            withMathJax(
              paste0(MENSAGEM_FIXA_INTERPRETACAO),
              br(),
              paste0("\\( \\beta_0 \\)", " nao e significativamente diferente de 0(p-value = ", round(summary(fit)$coefficients[1, 4], 3), ") entao quando ", input$xlab, " = 0, a media de", input$ylab, " nao e significativamente diferente de 0."),
              br(),
              paste0(" Para um aumento de uma unidade de ", input$xlab, ", ", input$ylab, ifelse(round(fit$coef[[2]], 3) >= 0, " aumenta (em media) em "," diminui (em média) em "), abs(round(fit$coef[[2]], 3)), ifelse(abs(round(fit$coef[[2]], 3)) >= 2, " unidades", " unit"), ".")
            )
          } else {
            withMathJax(
              paste0(MENSAGEM_FIXA_INTERPRETACAO),
              br(),
              paste0("\\( \\beta_0 \\)", " e ", "\\( \\beta_1 \\)", " nao sao significativamente diferentes de 0 (p-values = ", round(summary(fit)$coefficients[1, 4], 3), " e ", round(summary(fit)$coefficients[2, 4], 3), ",respectivamente) entao a media de ", input$ylab, "nao e significativamente diferente de 0.")
            )
          } 
        }
      })
      
      
      #interface
      tagList(tags$b(INTERFACE_LABEL_DATA),
              DT::dataTableOutput("tbl"),
              br(),
              uiOutput("data"),
              br(),
              tags$b(INTERFACE_PARAMETROS_COMPUTADOS),
              uiOutput("by_hand"),
              br(),
              tags$b(INTERFACE_PARAMETROS_COMPUTADOS_R),
              verbatimTextOutput("summary"),
              br(),
              tags$b(INTERFACE_GRAFICO),
              uiOutput("results"),
              plotlyOutput("plot"),
              br(),
              tags$b(INTERFACE_INTERPRETACAO),
              uiOutput("interpretation"),
              br(),
              br())
      
    }
    else{
      HTML(MENSAGEM_ERRO_DADOS)
    }
    
  })
  
}

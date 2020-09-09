#
#Service input
#
inputService = function(input,output,session,dataPlot){
  
  #================Atualizando inputs==================
  
  #inputs arquivo
  observe({
    if(is.null(input$arquivoUpload)){
      
      #desabilitante inputs
      disable("arquivoEixoX")
      disable("arquivoEixoY")
      
    } else{
      
      #obtendo arquivo
      dados = read.csv(input$arquivoUpload$datapath,
                       header = T,
                       sep = input$radio)
      
      if(length(names(dados)) > 1){
        
        #ativando inputs
        enable("arquivoEixoX")
        enable("arquivoEixoY")
        
        #carregando opcoes
        updateSelectInput(session,"arquivoEixoX",choices = names(dados))
        updateSelectInput(session,"arquivoEixoY",choices = names(dados)) 
      }
    }
    
  })
  #====================================================
  
  
  #================Report==============================
  
  output$downloadReport <- downloadHandler(
    filename = function() {
      paste("my-report", sep = ".", switch(
        input$format, PDF = "pdf", HTML = "html", Word = "docx"
      ))
    },
    
    content = function(file) {
      src <- normalizePath("report.Rmd")
      
      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, "report.Rmd", overwrite = TRUE)
      
      library(rmarkdown)
      out <- render("report.Rmd", switch(
        input$format,
        PDF = pdf_document(), HTML = html_document(), Word = word_document()
      ))
      file.rename(out, file)
    }
  )
  #==================================================
  
}
#
#Funcao para remover as virgulas do input
#
extract <- function(text) {
  text <- gsub(" ", "", text)
  split <- strsplit(text, ",", fixed = FALSE)[[1]]
  as.numeric(split)
}

#
#Este metodo escolhe o x e y do arquivo
#
escolhaArquivo = function(input,dados){
  
  if(!is.null(input$arquivoUpload) & length(names(dados) > 1)){
    
    x = dataPlot()[,input$arquivoEixoX]
    y = dataPlot()[,input$arquivoEixoY]
    
  } else
  {
    
    y = extract(input$y)
    x = extract(input$x)  
  }
  
  result = c(x,y)
  
  return(result)
}
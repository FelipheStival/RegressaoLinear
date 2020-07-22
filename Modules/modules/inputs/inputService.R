#
#Service input
#
inputService = function(input,output,session){
  
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
  
}
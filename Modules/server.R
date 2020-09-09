
server = function(input, output,session) {
    
    #==================Entrada de dados=====================
    
    dataPlot = reactive({
        
        dados = NULL
        
        if(!is.null(input$arquivoUpload)){
            
            #obtendo arquivo
            dados = read.csv(input$arquivoUpload$datapath,
                             header = T,
                             sep = input$radio)
            
            if(length(names(dados)) <= 1){
                dados = NULL
            }
            
        } else if(input$x != "" & input$y != ""){
            
            x = extract(input$x)
            y = extract(input$y)
            
            if(length(x) == length(y)){
                dados = data.frame(x,y) 
            }
        }
        
        return(dados)
    })
    
    #=====================================================
    
    #==============Iniciando services====================
    
    #Input service
    inputService(input,output,session,dataPlot)
    
    #plot service
    plotService(input,output,session,dataPlot)
    
    #=====================================================
    
}

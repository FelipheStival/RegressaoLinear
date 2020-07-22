#
#Esta funcao cria a interface para inputs 
#
createInputsUI = function(){
  
  sidebarPanel(
    useShinyjs(),
    #===================Entrada de dados manual==============================
    
    tags$b(INTERFACE_LABEL_DATA),
    hr(),
    tags$b(INTERFACE_INPUT_DIGITAR_MANUAL),
    textInput("x",INPUT_EIXO_X,value = "90, 100, 90, 80, 87, 75"),
    textInput("y",INPUT_EIXO_Y,value = "950, 1100, 850, 750, 950, 775"),
    
    #========================================================================
    
    hr(),
    tags$b(INTERFACE_LABEL_TIPO_INPUT),
    hr(),
    
    #==================Entrada por upload====================================
    
    fileInput("arquivoUpload",INPUT_UPLOAD_ARQUIVO),
    radioButtons("radio",INPUT_SELECIONAR_SEPARADOR,choices = list(";" = ";", "," = ","),selected = ";"),
    selectInput("arquivoEixoX",INPUT_EIXO_X,choices = NULL),
    selectInput("arquivoEixoY",INPUT_EIXO_Y,choices = NULL),
    
    #========================================================================
    
    #==================Opcoes graficos=======================================
    
    tags$b(INTERFACE_LABEL_PLOT),
    checkboxInput("se",INPUT_INTERVALO_CONFIANCA),
    tags$b(MENSAGEM_EIXOS),
    textInput("xlab",NULL),
    textInput("ylab",NULL),
    radioButtons("format",
                 INPUT_FORMATO_RELATORIO,
                 c("HTML","PDF","Word"),
                 inline = TRUE
    ),
    checkboxInput("echo",INPUT_SHOW_CODE,FALSE),
    downloadButton("downloadReport"),
  )
  
  #==========================================================================
  
}

#
#Esta funcao cria a interface para inputs 
#
createInputsUI = function(){
  
  sidebarPanel(
    useShinyjs(),
    tags$b("Data: "),
    hr(),
    tags$b("Digite: "),
    textInput("x",INPUT_EIXO_X,value = "90, 100, 90, 80, 87, 75"),
    textInput("y",INPUT_EIXO_Y,value = "950, 1100, 850, 750, 950, 775"),
    hr(),
    tags$b("ou"),
    hr(),
    fileInput("arquivoUpload","Escolha um arquivo"),
    radioButtons("radio","Selecione o separador: ",choices = list(";" = ";", "," = ","),selected = ";"),
    selectInput("arquivoEixoX","Eixo X",choices = NULL),
    selectInput("arquivoEixoY","Eixo Y",choices = NULL),
    tags$b("Plot: "),
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
  
}


ui = fluidPage(
    #================Criando pagina=========================
    titlePanel(NOME_APLICACAO),
    withMathJax(),
    
    #================inputs interface=======================
    
    sidebarLayout(
        createInputsUI(),
    #=======================================================
    
    
    #============plot interface=============================
        createPlotUI()
    )
    #=======================================================
)

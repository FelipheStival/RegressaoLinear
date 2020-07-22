
#==============================================#
# Carregando pacotes a serem utilizados
app.LoadPackages = function() 
{
  #=============================================#
  # Iniciando bibliotecas web
  
  require(shiny)
  require(ggplot2)
  require(plotly)
  require(rmarkdown)
  require(knitr)
  require(pander)
  require(shinyjs)
  
  
}
#==============================================#

#==============================================#
# Compilando arquivos
app.CompileModules = function() {
  
  require(compiler)
  
  modulos = list.files(pattern = ".R$", recursive = T, full.names = T)
  app.index = grep("app.R", modulos)
  modulos = modulos[-app.index]
  
  log = sapply(modulos, function(m.in) {
    m.out = strsplit(m.in, split = "\\.")[[1]]
    m.out[length(m.out)] = 'Rc'
    m.out = paste(m.out, collapse = ".")
    cmpfile(m.in, m.out)     
  })
}
#==============================================#

#==============================================#
# Carregando arquivos compilados
app.LoadModules = function() {
  
  require(compiler)
  
  modulos = list.files(pattern = ".Rc$", recursive = T, full.names = T)
  log = sapply(modulos, loadcmp)
}
#==============================================#

#==============================================#
# Removendo arquivos compilados
app.ResetModules = function() {
  modulos = list.files(pattern = ".Rc$", recursive = T, full.names = T)
  log = sapply(modulos, unlink)
}



#==============================================#

app.LoadPackages()
app.ResetModules()
app.CompileModules()
app.LoadModules()

shinyApp(ui, server)


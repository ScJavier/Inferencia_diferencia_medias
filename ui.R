library(shiny)

ui <- fluidPage(
  
  titlePanel('Hipótesis simple'),
  
  sidebarLayout(
    
    sidebarPanel(
      numericInput('mu0', 'Mu0', value = 3, step = 0.1),
      numericInput('mu1', 'Mu1', value = 5, step = 0.1),
      numericInput('s2', 'sigma2', value = 1, min = 0.1, step = 0.1),
      numericInput('n', 'Tamaño muestra', value = 20, min = 2, step = 1),
      numericInput('alfa', 'Significancia', value = 0.05, min = 0.005, 0.50, step = 0.005)
    ),
    
    mainPanel(
      
      plotOutput('prueba'),
      p('* El área roja corresponde a la significancia.'),
      p('* El área azul corresponde a la potencia.'),
      h4('Potencia'),
      verbatimTextOutput('potencia'),
      h4('Tamaño región de no rechazo'),
      verbatimTextOutput('tamano')
    )
  )
)

server <- function(input, output) {
  
  output$prueba <- renderPlot({
    
    media0 <- input$mu0
    media1 <- input$mu1
    desvest <- sqrt(input$s2/input$n)
    
    
    lim_inf_x <- qnorm(0.0001, min(media0, media1), desvest)
    lim_sup_x <- qnorm(0.9999, max(media0, media1), desvest)
    
    lim_inf_y <- 0
    lim_sup_y <- dnorm(media1, media1, desvest)
    
    z0sup <- qnorm(1-input$alfa/2, media0, desvest)
    z0inf <- qnorm(input$alfa/2, media0, desvest)
    
    plot(0, 0, type = 'n', xlim = c(lim_inf_x, lim_sup_x), ylim = c(lim_inf_y, lim_sup_y),
         ylab = '', xlab = '')
    
    sig_sup_x <- c(z0sup, seq(z0sup, qnorm(0.9999, media0, desvest), length.out = 100))
    sig_sup_y <- c(0, dnorm(sig_sup_x[-1], media0, desvest))
    polygon(sig_sup_x, sig_sup_y, col = 'red3', density = 50, angle = 45)
    
    sig_inf_x <- c(seq(qnorm(0.0001, media0, desvest), z0inf, length.out = 100), z0inf)
    sig_inf_y <- c(dnorm(sig_inf_x[-length(sig_inf_x)], media0, desvest), 0)
    polygon(sig_inf_x, sig_inf_y, col = 'red3', density = 50, angle = 45)
    
    pot_sup_x <- c(z0sup, seq(z0sup, qnorm(0.9999, media1, desvest), length.out = 100))
    pot_sup_y <- c(0, dnorm(pot_sup_x[-1], media1, desvest))
    polygon(pot_sup_x, pot_sup_y, col = 'steelblue3', density = 50)
    
    pot_inf_x <- c(seq(qnorm(0.0001, media1, desvest), z0inf, length.out = 100), z0inf)
    pot_inf_y <- c(dnorm(pot_inf_x[-length(pot_inf_x)], media1, desvest), 0)
    polygon(pot_inf_x, pot_inf_y, col = 'steelblue3', density = 50)

    curve(dnorm(x, media0, desvest), add = T, col = 'darkcyan', lwd = 3.5)
    curve(dnorm(x, media1, desvest), add = T, col = 'red3', lwd = 3.5)
    
    abline(h = 0, lwd = 3)
    
  })
  
  
  output$potencia <- renderText({
    media0 <- input$mu0
    media1 <- input$mu1
    desv_est <- sqrt(input$s2/input$n)
    
    z0_sup <- qnorm(1-input$alfa/2, media0, desv_est)
    z0_inf <- qnorm(input$alfa/2, media0, desv_est)
    
    pot <- pnorm(z0_inf, media1, desv_est) + pnorm(z0_sup, media1, desv_est, lower.tail = F)
    pot
  })
  
  output$tamano <- renderText({
    media0 <- input$mu0
    media1 <- input$mu1
    desv_est <- sqrt(input$s2/input$n)
    
    z0_sup <- qnorm(1-input$alfa/2, media0, desv_est)
    z0_inf <- qnorm(input$alfa/2, media0, desv_est)
    
    z0_sup - z0_inf
    
  })
  
}

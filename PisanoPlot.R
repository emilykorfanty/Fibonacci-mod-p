# Plot the Pisano periods modulo p up to p=N

library(ggplot2)
library(stringr)

N <- 10000

Pisano_plot <- function(N, save=T){
  
  p <- primes::generate_primes(max=N) 
  
  get_prd <- function(p){
    
    fib <- matrix(c(1,1,1,0), nrow=2, ncol=2, byrow=T)
    id <- matrix(c(1,0,0,1), nrow=2, ncol=2, byrow=T)
    
    A <- fib
    d <- 1
    
    while(!identical(A,id)){
      
      A <- (A %*% fib) %% p
      
      d <- d+1
      
    }
    
    return(d)
    
  }
  
  prd <- sapply(p, get_prd)
  
  prd_df <- data.frame(prime = p, period = prd)
  
  plt <- ggplot(prd_df, aes(x=p, y=prd)) + 
    geom_point(size=0.05) +
    xlab("p") +
    ylab("Period") +
    ggtitle("Periods of the Fibonacci Numbers Modulo p")
  
    plt
  
    file_nm <- paste0(
      "PisanoPlot_",
      N,
      "_primes-only_",
      format(Sys.time(), "%d-%b-%Y %H.%M"),
      ".pdf"
    )
  
  if(save==T){
    dev.copy(pdf, file_nm, width = 6, height = 4)
    dev.off()
  }
  
  return(prd_df)
  
}


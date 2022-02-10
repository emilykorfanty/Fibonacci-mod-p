# Plot the Pisano periods modulo p up to p=N

library(ggplot2)
library(stringr)
source("PeriodEstimate.R")

N <- 10000

Pisano_plot <- function(N, save=T, est_view=T){
  
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
  
  prd_df <- data.frame(prime = p, period = sapply(p, get_prd))
  
  prd_est <- get_est(N, est_view)
  
  plt <- ggplot(prd_df, aes(x=p, y=prd)) + 
    geom_point(size=0.05) +
    xlab("p") +
    ylab("Period (mod p)") +
    ggtitle("Periods of the Fibonacci Numbers Modulo p")
  
  for(i in 1:length(prd_est)){
    plt <- plt + 
      geom_function(fun = prd_est[[i]], color = "red")
  }
  
  plt
  
  file_nm <- paste0(
    "./Plots/",
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



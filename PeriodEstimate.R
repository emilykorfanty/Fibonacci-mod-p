# Estimate the Pisano periods for primes up to N ----

get_est <- function(est_view=T){
  
  est_funs <- list(
    a = function(x) 2*x+1,    
    b = function(x) x-1,      
    c = function(x) 2*(x+1)/3,  
    d = function(x) (x-1)/2,    
    e = function(x) (x+1)/3     
  )
  
  est_nms <- lapply(est_funs, function(X) stringr::str_replace_all(deparse(X)[2], " ", ""))
  
  # display summary of available estimates
  if(est_view){
    
    cat("\nAvailable period estimates:\n")
    
    mapply(
      function(x,y) cat(paste("Enter", x, "for", y, "\n")),
      x = names(est_funs),
      y = est_nms)
    
    cat("Enter 0 to include all estimates\n")
  }
  
  cat("\n")
  
  est <- stringr::str_to_lower(readline("Please enter a period estimate: "))
  
  if(est == "0") list(funs=est_funs, nms=est_nms) else list(funs=est_funs[est], nms=est_nms[est])

}



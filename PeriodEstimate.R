# Estimate the Pisano periods for primes up to N ----

estimate_prd <- function(N, est_view=T){
  
  est_cds <- c("a", "b", "c", "d", "e")
  
  est_nms <- c("2x + 1", "x - 1", "2*(x+1)/3", "(x-1)/2", "(x+1)/3")
  
  est_funs <- list(
    function(x) 2*x + 1,    # a
    function(x) x - 1,      # b
    function(x) 2*(x+1)/3,  # c
    function(x) (x-1)/2,    # d
    function(x) (x+1)/3     # e
  )
  
  get_est <- function(X, est_cd) sapply(X, est_funs[[which(est_cds==est_cd)]])
  
  # display summary of available estimates
  if(est_view){
    
    cat("\nAvailable period estimates:\n")
    
    mapply(
      function(x,y) cat(paste("Enter", x, "for", y, "\n")),
      x = est_cds,
      y = est_nms)
    
    cat("Enter 0 to include all estimates\n")
  }
  
  cat("\n")
  
  est <- stringr::str_to_lower(readline("Please enter a period estimate: "))
  
  if(est == "0") lapply(est_cds, function(cd) get_est(X,cd)) else list(get_est(X,est))

}



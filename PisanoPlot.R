# Plot the Pisano periods modulo p up to p=N

library(ggplot2)
library(ggrepel)
library(stringr)
library(dplyr)
library(reshape2)
library(latex2exp)
source("PeriodEstimate.R")

N <- 10000

cb_pal <- c(#"#999999", # grey
            #"#E69F00", # orange
            "#56B4E9", #  blue
            "#009E73", #  green
            "#F0E442", #  yellow
            #"#0072B2", # navy
            "#D55E00", #  brown
            "#CC79A7"  #  pink
            )

prd_est <- get_est()  # retrieve period estimation functions

# assign colours to estimates
names(cb_pal) <- prd_est$nms %>%
  str_replace_all("x", "p") %>%
  str_replace("\\*", "") #%>%
  # sapply(
  #   function(X) if(str_detect(X,"/")) paste0("$\\frac{",X,"}$") else paste0("$",X,"$")
  # ) %>%
  # str_replace("/", "}{") 

Pisano_plot <- function(N, pal, save=F){
  
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
  
  est <- prd_est$funs %>%
    lapply(
      function(F) sapply(p, function(x) do.call(F,list(x)))
    ) 
  names(est) <- prd_est$nms
  
  prd_df <- data.frame(prime = p, period = sapply(p, get_prd)) %>%
    bind_cols(est) %>%
    melt(id.vars = c("prime", "period"),
         variable.name = "label", 
         value.name = "estimate")
  
  plt <- prd_df %>%
    mutate(legend = if_else(prime == max(prime), as.character(label), NA_character_)) %>%
    ggplot(aes(x=prime, y=estimate, group=label, color=label)) +
    geom_line() +
    geom_label_repel(aes(label = legend),
                     box.padding = 0.1,
                     nudge_x=500,
                     size = 2.5,
                     xlim = c(NA, Inf),
                     parse=T,
                     na.rm=T) +
    scale_x_continuous(
      limits = c(0, N+1000)
    ) +
    scale_color_discrete(guide = "none") +
    geom_point(aes(x=prime,y=period),size=0.05,color='black') +
    xlab("p") +
    ylab("Period (mod p)") +
    ggtitle("Periods of the Fibonacci Numbers (mod p)") +
    theme(text = element_text(family = "sans"))
  plt
  
  # plt <- prd_df %>%
  #   ggplot(aes(x=prime, y=period)) +
  #   lapply(1:length(prd_est$funs), function(i) {
  #     est_nm <- names(pal)[i]
  #     est_fun <- prd_est$funs[[i]]
  #     line <- geom_function(fun = est_fun,
  #                           aes(colour = est_nm))
  #     list(line)
  #   }) +
  #   geom_label_repel(c(1,2,3,4,5)) +
  #   geom_point(size=0.05, alpha=0.5) +
  #   scale_colour_manual(name = NULL,
  #                       values = pal,
  #                       labels = unname(TeX(names(pal)))) +
  #   theme(legend.text.align = 0) +
  #   xlab("p") +
  #   ylab("Period (mod p)") +
  #   ggtitle("Periods of the Fibonacci Numbers Modulo Primes")
  # 
  # plt
  
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
  
  return(list(df = prd_df, plt = plt))
  
}

prd <- Pisano_plot(N, cb_pal, save=F)
prd$plt


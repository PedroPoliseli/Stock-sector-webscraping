install.packages("rvest")
library(rvest)




getSector.Ind <- function(x)
  {
  Sys.sleep(3)
  url = paste0("https://finance.yahoo.com/quote/",x,"/profile?p=",x)
  a <- suppressWarnings(read_html(url))
  industry <- a %>% html_nodes("div p span") %>% .[4] %>% html_text()
  sector <-a %>% html_nodes("div p span") %>% .[2] %>% html_text()
  industry <- as.data.frame(industry)
  sector <- as.data.frame(sector)
  tic <- as.data.frame(x)
  colnames("Ticker")
  cbind(tic, sector, industry)
}


tickers <- c("AAPL", "AMZN", "GOOGL", "aosdfoi"  , "TSLA")



ALL <- lapply(as.list(tickers), function(x)
{
  tmp <- try(getSector.Ind(x))
  if(!inherits(tmp, "try-error"))
    tmp
})

ALL <- ALL[lapply(ALL, length)>0]

ALL <- do.call(rbind, ALL)

View(ALL)




library(here)
library(rvest)
library(tidyverse)

total_da_jobs <- "https://www.seek.com.au/jobs/in-All-Melbourne-VIC/full-time?keywords=%27Data%20Analyst%22&page=5&salaryrange=0-999999&salarytype=annual#start-of-content"
tot_job <- read_html(total_da_jobs) %>% html_nodes("#SearchSummary ._7ZnNccT") %>% html_text()

da_seek_html <- "https://www.seek.com.au/jobs/in-All-Melbourne-VIC/full-time?keywords=%27Data%20Analyst%22&page=5&salaryrange=100000-999999&salarytype=annual#start-of-content"
tot_job_over_100k <- read_html(da_seek_html) %>% html_nodes("#SearchSummary ._7ZnNccT") %>% html_text()

# total jobs now stored

# seek pages to extract
pages <- 1:10

# initialise df

df <- data.frame(title = character(0),
                 company = character(0),
                 industry = character(0),
                 job_desc = character(0))


for(i in pages){
  
  site <- paste0("https://www.seek.com.au/jobs/in-All-Melbourne-VIC/full-time?keywords=%27Data%20Analyst%22&page=",i,"&salaryrange=100000-999999&salarytype=annual#start-of-content")

  stats <- data.frame(title = read_html(site) %>% html_nodes("._2S5REPk") %>% html_text(trim = TRUE),
                      company = read_html(site) %>% html_nodes("._2Ryjovs+ ._2Ryjovs :nth-child(2)") %>% html_text(trim = TRUE),
                      industry = read_html(site) %>% html_nodes("._1edaxlv ._7ZnNccT ._17sHMz8") %>% html_text(trim = TRUE),
                      job_desc = read_html(site) %>% html_nodes("._2OKR1ql") %>% html_text(trim = TRUE))

  stats$title <- stats$title
  stats$company <- stats$company
  stats$industry <- stats$industry
  stats$job_desc <- stats$job_desc
  
  df <- rbind(df, stats)
  
}


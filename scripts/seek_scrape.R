library(here)
library(rvest)
library(tidyverse)

da_seek_html <- "https://www.seek.com.au/jobs/in-All-Melbourne-VIC/full-time?keywords=%27Data%20Analyst%22&page=5&salaryrange=100000-999999&salarytype=annual#start-of-content"

da_seek_html_two <- "https://www.seek.com.au/jobs/in-All-Melbourne-VIC/full-time?keywords=%27Data%20Analyst%22&page=2&salaryrange=100000-999999&salarytype=annual"





seek <- read_html(da_seek_html)
seek_two <- read_html(da_seek_html_two)

seek_title <- seek %>% html_nodes("._2S5REPk") %>% html_text(trim = TRUE)
job_desc <- seek %>% html_nodes("._2OKR1ql") %>% html_text(trim = TRUE)
company <- seek %>% html_nodes("._2Ryjovs+ ._2Ryjovs ._17sHMz8") %>% html_text(trim = TRUE)
industry <- seek %>% html_nodes("._1edaxlv ._7ZnNccT ._17sHMz8") %>% html_text(trim = TRUE)
  

df <- bind_cols(job_title = seek_title,
                company = company,
                industry = industry,
                job_desc = job_desc)

df

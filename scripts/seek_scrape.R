library(rvest)
library(tidyverse)

# total jobs available df

total_da_jobs <- "https://www.seek.com.au/jobs/in-All-Melbourne-VIC/full-time?keywords=%27Data%20Analyst%22&page=5&salaryrange=0-999999&salarytype=annual#start-of-content"
tot_job <- read_html(total_da_jobs) %>% html_nodes("#SearchSummary ._7ZnNccT") %>% html_text()

da_seek_html <- "https://www.seek.com.au/jobs/in-All-Melbourne-VIC/full-time?keywords=%27Data%20Analyst%22&page=5&salaryrange=100000-999999&salarytype=annual#start-of-content"
tot_job_over_100k <- read_html(da_seek_html) %>% html_nodes("#SearchSummary ._7ZnNccT") %>% html_text()


job_cat <- c("all_da_jobs", "da_jobs_over_100k")
job_counts <- c(tot_job, tot_job_over_100k)


jobs_df <- bind_cols(category = job_cat, count = job_counts)

# seek pages to extract
pages <- 1:11

# initialise df

df <- data.frame(title = character(0),
                 company = character(0),
                 industry = character(0),
                 job_desc = character(0),
                 link = character(0))


# scrape multiple pages on seek.com.au


for(i in pages){
  
  site <- paste0("https://www.seek.com.au/jobs/in-All-Melbourne-VIC/full-time?keywords=%27Data%20Analyst%22&page=",i,"&salaryrange=100000-999999&salarytype=annual#start-of-content")

  stats <- data.frame(title = read_html(site) %>% html_nodes("._2S5REPk") %>% html_text(trim = TRUE),
                      company = read_html(site) %>% html_nodes("._2Ryjovs+ ._2Ryjovs :nth-child(2)") %>% html_text(trim = TRUE),
                      industry = read_html(site) %>% html_nodes("._1edaxlv ._7ZnNccT ._17sHMz8") %>% html_text(trim = TRUE),
                      job_desc = read_html(site) %>% html_nodes("._2OKR1ql") %>% html_text(trim = TRUE),
                      link = paste0("seek.com.au", read_html(site) %>% html_nodes("._2S5REPk") %>% html_attr("href")))

  stats$title <- stats$title
  stats$company <- stats$company
  stats$industry <- stats$industry
  stats$job_desc <- stats$job_desc
  stats$link <- stats$link
  
  df <- rbind(df, stats)
  
}

# remove duplicate jobs from same company

df_clean <- df %>%
  mutate(helper = paste(company, job_desc)) %>%
  distinct(helper, .keep_all = TRUE) %>%
  select(-helper)

# pbi source code source("C:/Users/mpitt/OneDrive - Macpherson Kelley/Documents/R/seek/scripts/seek_scrape.R")


# stored as of todays date
write.csv(df_clean, file = "C:/Users/mpitt/OneDrive - Macpherson Kelley/Documents/R/seek/data/data_analyst_jobs_from_seek.csv", row.names = FALSE)
write.csv(df_clean, file = "C:/Users/mpitt/OneDrive - Macpherson Kelley/Documents/R/seek/data/jobs_df.csv", row.names = FALSE)


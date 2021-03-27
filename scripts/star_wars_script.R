library(rvest)
library(tidyverse)

starwars <- read_html("https://rvest.tidyverse.org/articles/starwars.html")

films <- starwars %>% html_nodes("h2")
films

episode <- films %>% html_attr("data-id") %>% readr::parse_integer()
episode

title <- starwars %>% 
  html_nodes("h2") %>% 
  html_text(trim = TRUE)

title

df <- bind_cols(episode = episode, title = title)
 
df

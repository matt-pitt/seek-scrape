library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

lego_movie %>%
  html_node("strong span") %>%
  html_text(trim = TRUE)

lego_movie %>%
  html_nodes(".primary_photo+ td a") %>%
  html_text(trim = TRUE)

# not overly helpful

lego_movie %>%
  html_nodes(".user-comments div :nth-child(1)") %>%
  html_text(trim = TRUE)

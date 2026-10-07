library(tidyverse)
library(tidytext)
library(wordcloud)

tweets <- read_csv("tweets.csv")

words <- tweets %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word")

words %>%
  inner_join(get_sentiments("bing"), by = "word") %>%
  count(sentiment) %>%
  ggplot(aes(sentiment, n, fill = sentiment)) +
  geom_col() +
  labs(title = "Sentiment Analysis")

words %>%
  count(word, sort = TRUE) %>%
  with(wordcloud(word, n, max.words = 100))

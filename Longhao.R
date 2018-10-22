library(dplyr)
library(stringr)
library(tidytext)
library(tidyverse)
get_sentiments("bing")


read.table(file = "Harry Potter and the Sorcerer's Stone.txt")
hp <- read_table("Harry Potter and the Sorcerer's Stone.txt")

#Tokenlize dataframe
hp <- hp %>% unite(., sep = " ")
colnames(hp) <- c("word")
hp %>% unnest_tokens(output = word,input = word) -> token_hp


# Take out stop words

data(stop_words)
token_hp <- token_hp %>%
  anti_join(stop_words)

#Most common words
most_common <- token_hp %>%
  count(word, sort = TRUE) 

#ggplot2

token_hp %>%
  count(word, sort = TRUE) %>%
  top_n(20) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()


dane %>%
  filter(Series.or.Movie == "Movie", Director == "Woody Allen") %>%
  arrange(as.Date(Release.Date, format = "%m/%d/%Y")) %>%
  slice(1) %>%
  select(Title, Release.Date, Director)
dane %>%
  filter(Release.Date %in% c(2019, 2020)) %>%
  mutate(Release.Date = as.Date(Release.Date, format = "%m/%d/%Y"),
    Date.Added = as.Date(Release.Date, format = "%B %d, %Y"),
    czas = as.numeric(Release.Date)) %>%
  summarise(sredni_czas = mean(Runtime))
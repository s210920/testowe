dane %>%
  filter(Release.Date %in% c(2019, 2020)) %>%
  mutate(Release.Date = as.Date(Release.Date, format = "%m/%d/%Y"),
    Date.Added = as.Date(Date.Added, format = "%B %d, %Y"),
    czas = as.numeric(Date.Added - Release.Date)) %>%
  summarise(sredni_czas = mean(czas, na.rm = TRUE))
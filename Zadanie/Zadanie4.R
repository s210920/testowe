wynik <- dane %>%
drop_na(Release.Date, Netflix.Release.Date) %>%
  mutate(
    rok = lubridate::year(Release.Date), 
    roznica = Netflix.Release.Date - Release.Date
  ) %>%
  filter(rok %between% c(2019, 2020)) %>%
  group_by(rok) %>%
  summarize(srednia_dni = mean(roznica) %>% round(0))
print(wynik)

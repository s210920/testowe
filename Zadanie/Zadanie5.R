drop_na(Release.Date, IMDb.Score) %>%
    mutate(
    rok = year(Release.Date),
    dekada = rok - (rok %% 10)
  ) %>%
  filter(dekada >= 1960) %>%

  group_by(dekada) %>%
  summarize(
    srednia_ocena = mean(IMDb.Score, na.rm = TRUE) %>% round(2),
    liczba_filmow = n()
  ) %>%
  
  arrange(dekada)
print(oceny_w_dekadach)
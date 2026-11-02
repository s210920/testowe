# ANALIZA NIERUCHOMOŚCI

library(dplyr)

adres_nieruchomosci <- paste0(
  "https://raw.githubusercontent.com/kflisikowsky/pandas_exercises/",
  "62863036107888c0c7273c40e8d309a43f4da3a9/data/models/real_estate.csv"
)
raw_nier <- read.csv(adres_nieruchomosci, check.names = FALSE)
stopifnot(nrow(raw_nier) == 414, ncol(raw_nier) == 7)

nier <- raw_nier
names(nier) <- c("id", "wiek_lat", "metro_m", "sklepy", "lat", "lon",
                 "cena_10k_twd_ping")
head(nier)

# ZADANIE 1 

dim(nier) # Liczba wierszy i kolumn

str(nier) # Typy danych

summary(nier) # Statystyki podstawowe

colSums(is.na(nier)) # Liczba braków danych

anyDuplicated(nier$id) # Sprawdzenie unikatowości identyfikatorów

# Wnioski:
# Zbiór zawiera 414 obserwacji i 7 zmiennych
# Wszystkie zmienne są zapisane w formacie liczbowym
# W danych nie wystepują braki ani powtarzające się ID
# Średni wiek budynków wynosi 17,71 lat, a średnia odległość od metra wynosi 1083,89 m
# Zmienna id jest identyfikatorem, natomiast lat i lon oznaczają współrzędne geograficzne
# Nie należy interpretować ich jako zwykłych miar ilościowych

# ZADANIE 2 

# Przeliczenie ceny na TWD za m2
nier <- nier %>%
  mutate(cena_twd_m2 = cena_10k_twd_ping * 10000 / 3.3)

# Podstawowe statystyki cen
nier %>%
  summarise(
    minimum = min(cena_twd_m2),
    mediana = median(cena_twd_m2),
    srednia = mean(cena_twd_m2),
    maksimum = max(cena_twd_m2)
  )

# Pięć nieruchomości z najwyższą ceną
nier %>%
  arrange(desc(cena_twd_m2)) %>%
  select(id, cena_twd_m2, wiek_lat, metro_m, sklepy) %>%
  slice_head(n = 5)

# Wnioski:
# Średnia cena jednostkowa wynosi 115091.50 TWD/m2, natomiast mediana wynosi 116515.20 TWD/m2
# Średnia jest nieznacznie niższa od mediany, co może wskazywać na lewostronną asymetrię rozkładu cen
# Wszystkie pięć nieruchomości o najwyższej cenie znajduje się w odległosci do 500 m od metra

# ZADANIE 3 

# Utworzenie grup nieruchomości
nier <- nier %>%
  mutate(blisko_metra = metro_m <= 500)

# Liczba nieruchomości do 500 m i ich odsetek
nier %>%
  summarise(
    liczba = sum(blisko_metra),
    odsetek = mean(blisko_metra) * 100
  )

# Porównanie median cen w obu grupach
nier %>%
  group_by(blisko_metra) %>%
  summarise(
    liczba = n(),
    mediana_ceny = median(cena_twd_m2)
  )

# Wnioski:
# W badanej próbie 211 nieruchomości (50,97%) znajduje się w odległości do 500 m od stacji metra
# Mediana ich ceny wynosi 135 758 TWD/m2, podczas gdy dla nieruchomości położonych dalej niż 500 m wynosi 85 152 TWD/m2
# Oznacza to, że mediana cen w grupie nieruchomości położonych bliżej metra jest o około 59,4% wyższa
# Jest to zależność opisowa i nie stanowi dowodu na przyczynowy wpływ odległości od metra na cenę

# ZADANIE 4

# Podział nieruchomości na trzy strefy
nier <- nier %>%
  mutate(
    strefa = cut(
      metro_m,
      c(-Inf, 500, 1500, Inf),
      labels = c("do 500 m", "500-1500 m", "ponad 1500 m")
    )
  )

# Porównanie trzech stref
nier %>%
  group_by(strefa) %>%
  summarise(
    liczba = n(),
    mediana_ceny = median(cena_twd_m2),
    mediana_wieku = median(wiek_lat),
    srednia_sklepow = mean(sklepy)
  )

# Porownanie stref dla budynkow do 20 lat

nier %>%
  filter(wiek_lat <= 20) %>%
  group_by(strefa) %>%
  summarise(
    liczba = n(),
    mediana_ceny = median(cena_twd_m2)
  )

# Wnioski:
# Po ograniczeniu analizy do budynków w wieku do 20 lat ranking median cen w poszczególnych strefach pozostał bez zmian
# Najwyższą medianę odnotowano w odległości do 500 m od metra (144 545 TWD/m2), następnie w strefie 500–1500 m (111 667 TWD/m2), a najniższą powyżej 1500 m (73 182 TWD/m2)
# Różnice w medianach mogą wynikać z odmiennej struktury wieku budynków w poszczególnych strefach
# Wiek budynku może być dodatkowym czynnikiem związanym z poziomem cen nieruchomości

# RAPORT 3 - ANALIZA DANYCH W R
# Osoba B - zadania 5 i 6
# Badanie CBOS 2017

# Wczytanie pakietów
library(dplyr)
library(haven)

# Pobranie danych
adres <- "https://raw.githubusercontent.com/kflisikowsky/sad/main/data/CBOS_201733_331_SPSS.sav"

plik <- tempfile(fileext = ".sav")
download.file(adres, plik, mode = "wb")

dane <- read_sav(plik)
unlink(plik)

# Przygotowanie zmiennych
cbos <- dane %>%
  transmute(
    plec = as_factor(plec),
    miejscowosc = as_factor(klm6),
    kierunek = as_factor(q24)
  )


# ==========================================
# ZADANIE 5 - POZNAJ RESPONDENTÓW
# ==========================================

# Liczba respondentów
nrow(cbos)

# Liczba braków danych
colSums(is.na(cbos))

# Płeć - liczności i procenty
cbos %>%
  filter(!is.na(plec)) %>%
  count(plec) %>%
  mutate(procent = round(100 * n / sum(n), 2))

# Miejscowość - liczności i procenty
cbos %>%
  filter(!is.na(miejscowosc)) %>%
  count(miejscowosc) %>%
  mutate(procent = round(100 * n / sum(n), 2))

# Liczba odpowiedzi dotyczących miejscowości
cbos %>%
  filter(!is.na(miejscowosc)) %>%
  summarise(liczba_odpowiedzi = n())


# ==========================================
# ZADANIE 6 - KIERUNEK ZMIAN W POLSCE
# ==========================================

# Liczności i procenty wszystkich odpowiedzi
cbos %>%
  filter(!is.na(kierunek)) %>%
  count(kierunek, sort = TRUE) %>%
  mutate(procent = round(100 * n / sum(n), 2))

# Procent "W dobrym" wśród odpowiedzi
# "W dobrym" i "W złym"
cbos %>%
  filter(kierunek %in% c("W dobrym", "W złym")) %>%
  summarise(
    liczba = n(),
    procent = round(100 * mean(kierunek == "W dobrym"), 2)
  )

# Procent "W dobrym" w całej próbie
cbos %>%
  summarise(
    liczba = n(),
    procent = round(100 * mean(kierunek == "W dobrym", na.rm = TRUE), 2)
  )

# ==========================================
# WNIOSKI - ZADANIA 5 I 6
# ==========================================

# Zadanie 5:
# Badanie obejmowało 925 respondentów.
# Kobiety stanowiły 54%, a mężczyźni 46% próby.
# Na wsi mieszkało 43,78% respondentów,
# a w miastach powyżej 500 tys. mieszkańców 8,97%.
# Mianownik wynosił 925, ponieważ nie było braków danych.

# Zadanie 6:
# Najczęściej wskazywano odpowiedź "W dobrym" (46,7%).
# Wśród osób z jednoznaczną oceną odsetek ten
# wynosił 55,6% (432 z 777 respondentów).
# Różnica wynika z wykluczenia odpowiedzi
# "Trudno powiedzieć" oraz odmów odpowiedzi.
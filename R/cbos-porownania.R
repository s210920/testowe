### Zadanie 7 — wieś i duże miasta

Wybierz respondentów z kategorii `miejscowosc` równych `"wieś"` i `"miasto 500 000 i więcej"`. Dla każdej z tych dwóch grup policz **procent** odpowiedzi na pytanie `kierunek` (procent w obrębie grupy, nie w całej tabeli). Czy udział odpowiedzi „W złym” był taki sam?
  
  Sprawdź liczbę respondentów w obu grupach. Samo porównanie procentów bez liczebności może być mylące.

```{r cbos-zad-7}
# WASZE ROZWIĄZANIE
# filter(...), count(miejscowosc, kierunek), group_by(miejscowosc)

library(dplyr)
dane %>%
  filter(miejscowosc %in% c("wieś", "miasto 500 000 i więcej")) %>%
  count(miejscowosc, kierunek) %>%
  group_by(miejscowosc) %>%
  ```

### Zadanie 8 — ocena teraźniejszości a oczekiwania

Zrób tabelę liczności odpowiedzi na `prognoza`. Następnie ogranicz dane do osób oceniających sytuację w kraju jako `"W złym"` i sprawdź, jak odpowiadały na pytanie o przyszłość. Która odpowiedź była najczęstsza w tej grupie? Czy na podstawie tej tabeli można wyciągać wnioski przyczynowe?
  
  ```{r cbos-zad-8}
# WASZE ROZWIĄZANIE
# filter(kierunek == "W złym"), count(prognoza, sort = TRUE)

# Tabela liczności odpowiedzi na prognoza
dane %>%
  count(prognoza, sort = TRUE)

# Odpowiedzi osób oceniających sytuację w kraju jako "W złym"
dane %>%
  filter(kierunek == "W złym") %>%
  count(prognoza, sort = TRUE)
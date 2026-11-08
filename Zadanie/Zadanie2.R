```{r 34, eval=FALSE}
dane%>%
 filter(Genre%>%
 str_detected ('Comedy")) %>%
 fiter(Languages%>%
str_detected ('Polish')) %>%
arrange(-IMDb.Score) %>%
select(Title, IMDb.Score) %>%
top_n(3)
```
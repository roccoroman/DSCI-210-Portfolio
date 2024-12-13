library(readxl)
library(tidyverse)
library(sf)
library(readxl)
library(RColorBrewer)

summary_2024 <- read_xlsx("details_2024.xlsx")

map2024 <- st_zm(st_read("data/maps/precincts_2024.shp"))

class(map2024)
print(map2024,n=3)


mapANDresults2024 <-
  left_join(map2024, summary_2024, by = c("precincts" = "precincts"))


mapANDresults2024 %>% 
  mutate(Biden.prop = `Biden & Harris  (Dem)`/( `Biden & Harris  (Dem)`+ `Trump & Pence       (Rep)`)) %>%
  ggplot(aes(fill=Biden.prop)) +
  geom_sf()

mapANDresults2024 %>% 
  mutate(Biden.prop = `Biden & Harris  (Dem)`/( `Biden & Harris  (Dem)`+ `Trump & Pence       (Rep)`)) %>%
  ggplot(aes(fill=Biden.prop)) +
  geom_sf()+
  labs(title = "2024 Prosecutors Election", 
       subtitle = "Connie Pilich v Melissa Powers",
       fill = "Vote for \nPowers (%)", 
       caption = "")+
  scale_fill_gradientn(colours=brewer.pal(n=6,name="RdBu"),na.value = "transparent",                        breaks=c(0,.25,0.5,.75,1),labels=c("0%","25%","50%","75%","100%"),
                       limits=c(0,1))
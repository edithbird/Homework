library(leaflet)
library(rgdal)
library(ggmap)
library(dplyr)
library(knitr)


City1 <- c("Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Bangor","Belfast","Calais", "Damariscotta", "Dexter","Ellsworth","Ellsworth","Ellsworth","Farmington","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent","Fort Kent", "Houlton", "Houlton", "Houlton","Lewiston","Lewiston","Lewiston","Lewiston","Lewiston","Lewiston","Lewiston","Lewiston","Lewiston","Lewiston", "Machias", "Machias", "Norway","Norway","Presque Isle","Presque Isle","Presque Isle","Presque Isle","Presque Isle","Presque Isle","Presque Isle","Presque Isle","Presque Isle","Presque Isle","Presque Isle","Presque Isle","Presque Isle", "Rockland","Rockland","Rockland","Rockland","Rockland","Rockland","Rockland","Rockland","Rockland","Rockland","Rockland","Rumford","Skowhegan","Skowhegan","Skowhegan","Skowhegan","Skowhegan","Skowhegan","Skowhegan","Skowhegan","Waterville","Waterville","Waterville")


County1 <- c("Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Penobscot","Waldo", "Washington", "Lincoln", "Penobscot","Hancock","Hancock","Hancock","Franklin","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Androscoggin","Androscoggin","Androscoggin","Androscoggin","Androscoggin","Androscoggin","Androscoggin","Androscoggin","Androscoggin","Androscoggin","Washington", "Washington", "Oxford", "Oxford", "Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Aroostook","Knox","Knox","Knox","Knox","Knox","Knox","Knox","Knox","Knox","Knox","Knox","Oxford", "Somerset","Somerset","Somerset","Somerset","Somerset","Somerset","Somerset","Somerset","Kennebec","Kennebec","Kennebec")
City1 <- as.character(City1)
City1 <- paste(City1, "Maine",sep = " ")
Leahs1 <- cbind.data.frame(City1, County1)


Location1 <- geocode(City1)
head(Location1)

write.csv(Location1, "ClinicLocations.csv", row.names = FALSE)
Location2 <- Location1 %>% mutate(Lat = jitter(Location1$lat), Lon = jitter(Location1$lon)) %>% select(Lat, Lon)
write.csv(Location2, "ClinicLocations2.csv", row.names = FALSE)

Leahs2 <- cbind.data.frame(Leahs1, Location1)
Leahs2 <- Leahs2 %>% mutate(Lat1 = jitter(lat), Lon1 = jitter(lon)) %>% select(City, County1, Lat1, Lon1)
#Leahs2 <- Leahs2 %>% mutate(Lat11 = round(Lat1, digits = 2), Lon11 = round(Lon1, digits = 2)) %>% select(City, County1, Lat11,Lon11 )
Leahs2 <- Leahs2 %>% mutate(Lat37 = jitter(Lat1), Lon37 = jitter(Lon1)) %>% select(City, County1, Lat, Lon)

names(Leahs2)



IconHosp <- makeIcon(iconUrl = "https://cdn1.iconfinder.com/data/icons/Map-Markers-Icons-Demo-PNG/128/Map-Marker-Drawing-Pin-Right-Pink.png", iconWidth = 27, iconHeight = 31, iconAnchorX = 31*215/230/2, iconAnchorY = 16)


popupLabel <- paste(Leahs2$City, "has")



New <- leaflet() %>% addTiles() %>% addMarkers(lng = jitter(Leahs2$Lon), lat = jitter(Leahs2$Lat), 
                                               icon = IconHosp, popup = popupLabel
) %>% setView(lng = -70.0589, lat = 43.3601, zoom = 6) %>% addProviderTiles("CartoDB.Positron")
New
# Leahs1 <- mutate(Leahs1, City = gsub(" Maine", "", City1)) %>% select(City, County1)
# head(Leahs1)
# str(Leahs1)
# ClinicbyCounty1 <- Leahs1 %>% group_by(County1)
# head(ClinicbyCounty1)

New2 <- leaflet() %>% addTiles() %>% addMarkers(lng = jitter(Location1$lon), lat = jitter(Location1$lat), 
                                               icon = IconHosp, popup = popupLabel
) %>% setView(lng = -70.0589, lat = 43.3601, zoom = 6) %>% addProviderTiles("CartoDB.Positron")
New

a <- runif(98, 1.001, 1.003)
head(a)
b <- runif(98, 1.001, 1.003)
head(b)
NewColumns <- cbind.data.frame(a, b)
head(NewColumns)

library(leaflet)
library(rgdal)
library(ggmap)
library(dplyr)
library(knitr)
library(raster)
library(sp)
library(ggplot2)
setwd("/Users/Chris Iyer/Documents/")
clinicsAb <- read.csv("AltClinics.csv")

clinicsAb$CNTYCODE <- as.factor(clinicsAb$CNTYCODE)
clinicsAb <- clinicsAb %>% mutate(filler = jitter(CountyClinics)/100)
names(clinicsAb)
head(clinicsAb)


ggplot(clinicsAb, aes(x = clinicsAb$County, y = clinicsAb$Clinics, label = clinicsAb$City, xlab = "County", ylab = "Number of Clinics in County")) +
  geom_point(aes(size = clinicsAb$Clinics, stroke = 5, colour = clinicsAb$City)) +
  scale_size(range = c(8,18)) +  
  labs(title = "Clinics in Maine", x = "County", y = "Number of clinics") + ylim(c(0, 25)) + theme_bw() + theme(legend.position="none") + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())+ 
  geom_text(hjust = 0.5, size = 3.2)

me_counties <- me_counties <- readOGR("./county", "county")
kable(head(me_counties))
names(me_counties)
me_counties <- spTransform(me_counties, CRS("+proj=longlat +datum=WGS84"))
x <- sp::merge(me_counties, clinicsAb, by = 'CNTYCODE', duplicateGeoms = TRUE)
dim(x)

pal <- colorQuantile("Ylgn", domain = clinicsAb$filler, reverse = TRUE, n = 4)
IconHosp <- makeIcon(iconUrl = "https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTaNgIjVruTY_rebXeXNgWuDQGMNrJ_rXaBZ0PIQzz-TCyzCcsddA", iconWidth = 31*215/230, iconHeight = 31, iconAnchorX = 31*215/230/2, iconAnchorY = 16)
popupLabel <- paste(clinicsAb$City, " has ", clinicsAb$Clinics, " clinics for your abortion pleasure. There are", clinicsAb$CountyClinics, "clinics in", clinicsAb$County, "county.")
XX <- leaflet() %>% 
  addProviderTiles("CartoDB.PositronNoLabels") %>% 
  addPolygons(data = x, color = "beige", weight = 2) %>% fitBounds(-70.55, 47.26, -66.28, 44.03)


XX
#leaflet() %>% addProviderTiles("CartoDB.PositronNoLabels") %>% addPolygons(data = x, fillColor = ~pal(CountyClinics), color = "##D46A6A", weight = 1, popup = ~popupLabel) %>% addMarkers(clinicsAb, lng = clinicsAb$lon, lat = clinicsAb$lat, popup = popupLabel, icon = IconHosp) 
library(tidyverse)
library(highcharter)
library(readr)
library(xlxs)
library(tidyr)
library(ggplot2)
library(reshape2)
library(lubridate)
library(writexl)


df <- read_delim("c1.csv", 
                 ",", escape_double = FALSE, trim_ws = TRUE)
df %>% 
  summarise(postes_distintos= n_distinct(ID))

#al parceter tenemos 74239 postes distintos

df %>% 
  summarise(ubicaciones_distintas = n_distinct(origen))

# al parecer tenemos 4 ubicaciones distitnas de salida

###
df <- df %>% mutate(Camion_5 = as.numeric(gsub("Q", "", Camion_5)))
df <- df %>% mutate(directoCamion_5 = as.numeric(gsub("Q", "", directoCamion_5)))
df <- df %>% mutate(fijoCamion_5 = as.numeric(gsub("Q", "", fijoCamion_5)))

df <- df %>% mutate(Pickup = as.numeric(gsub("Q", "", Pickup)))
df <- df %>% mutate(directoPickup = as.numeric(gsub("Q", "", directoPickup)))
df <- df %>% mutate(fijoPickup = as.numeric(gsub("Q", "", fijoPickup)))

df <- df %>% mutate(Moto = as.numeric(gsub("Q", "", Moto)))
df <- df %>% mutate(directoMoto = as.numeric(gsub("Q", "", directoMoto)))
df <- df %>% mutate(fijoMoto = as.numeric(gsub("Q", "", fijoMoto)))

df <- df %>% mutate(factura = as.numeric(gsub("Q", "", factura)))

df[23:28] <- list(NULL)
View(df)
###
postes_mas_visitados <-df %>% 
  select(ID) 

postes_mas_visitados <- postes_mas_visitados %>%   group_by(ID) %>% 
  summarise(cantidad_de_visitas = n ()) %>% 
  arrange(desc(cantidad_de_visitas))


write_xlsx(postes_mas_visitados, "postes.xlsx")

View(postes_mas_visitados)
####################################################################CAMION
camion <- df %>% 
  select(Camion_5,directoCamion_5,fijoCamion_5,factura,height, origen, Cod, ID, Fecha) 
  
camion1 <- df %>% 
  select(ID,Camion_5,`5-30`,`30-45` , `45-75` , `75-120` , `120+`) %>% 
  drop_na("Camion_5")

View(camion1)

camion1 %>% 
  group_by(`5-30`,`30-45` , `45-75` , `75-120` , `120+`) %>% 
  summarise(cantidad_veces = n ()) %>% 
  arrange(desc(cantidad_veces))



#camion1 <- na.omit(camion1)




camion <- na.omit(camion)
camion <- drop_na(camion$Camion_5)
View(camion)

uso_camion <- 62267

total_gasto_camion <- sum(camion$Camion_5)

total_costofijo_camion <- sum(camion$fijoCamion_5)

total_costodirecto_camion <- sum(camion$directoCamion_5)

total_factura_camion <- sum(camion$factura)



total_ganancia_camion <- total_factura_camion - total_gasto_camion


camion %>% 
  group_by(origen) %>% 
  summarise(Cantidad_de_salidas = n ()) %>% 
  arrange(desc(Cantidad_de_salidas))

camion %>% 
  group_by(Cod) %>% 
  summarise(Cantidad_de_caso = n ()) %>% 
  arrange(desc(Cantidad_de_caso))

camion %>% 
  group_by(height) %>% 
  summarise(altura_de_poste = n ()) %>% 
  arrange(desc(altura_de_poste))


tarifa_camion <- sum(camion$factura) / uso_camion


################################################################CAMION

####################################################################pickup
Pickup <- df %>% 
  select(Pickup,directoPickup,fijoPickup,factura,height, origen, Cod, ID, Fecha)

Pickup1 <- df %>% 
  select(ID,Pickup,`5-30`,`30-45` , `45-75` , `75-120` , `120+`) %>% 
  drop_na("Pickup")

Pickup <- na.omit(Pickup)
View(Pickup)

Pickup1 %>% 
  group_by(`5-30`,`30-45` , `45-75` , `75-120` , `120+`) %>% 
  summarise(cantidad_veces = n ()) %>% 
  arrange(desc(cantidad_veces))





uso_Pickup <- 195733
total_gasto_Pickup <- sum(Pickup$Pickup)
total_costofijo_Pickup <- sum(Pickup$fijoPickup)
total_costofijo_Pickup

total_costodirecto_Pickup <- sum(Pickup$directoPickup)
total_costodirecto_Pickup
total_factura_Pickup <- sum(Pickup$factura)
total_factura_Pickup

total_ganancia_Pickup <- total_factura_Pickup - total_gasto_Pickup

Pickup %>% 
  group_by(origen) %>% 
  summarise(Cantidad_de_salidas = n ()) %>% 
  arrange(desc(Cantidad_de_salidas))

Pickup %>% 
  group_by(Cod) %>% 
  summarise(Cantidad_de_caso = n ()) %>% 
  arrange(desc(Cantidad_de_caso))

Pickup %>% 
  group_by(height) %>% 
  summarise(altura_de_poste = n ()) %>% 
  arrange(desc(altura_de_poste))


tarifa_pickup <- sum(Pickup$factura) / uso_Pickup


################################################################pickup

################################################################Moto
Moto <- df %>% 
  select(Moto,directoMoto,fijoMoto,factura,height,origen, Cod, ID, Fecha)

Moto1 <- df %>% 
  select(ID,Moto,`5-30`,`30-45` , `45-75` , `75-120` , `120+`) %>% 
  drop_na("Moto")

Moto <- na.omit(Moto)
View(Moto)


Moto1 %>% 
  group_by(`5-30`,`30-45` , `45-75` , `75-120` , `120+`) %>% 
  summarise(cantidad_veces = n ()) %>% 
  arrange(desc(cantidad_veces))
  






uso_Moto <- 5725
total_gasto_Moto <- sum(Moto$Moto)
total_costofijo_Moto <- sum(Moto$fijoMoto)
total_costofijo_Moto
total_costodirecto_Moto <- sum(Moto$directoMoto)
total_costodirecto_Moto
total_factura_Moto <- sum(Moto$factura)
total_factura_Moto
total_ganancia_Moto <- total_factura_Moto - total_gasto_Moto

Moto %>% 
  group_by(origen) %>% 
  summarise(Cantidad_de_salidas = n ()) %>% 
  arrange(desc(Cantidad_de_salidas))

Moto %>% 
  group_by(Cod) %>% 
  summarise(Cantidad_de_caso = n ()) %>% 
  arrange(desc(Cantidad_de_caso))

Moto %>% 
  group_by(height) %>% 
  summarise(altura_de_poste = n ()) %>% 
  arrange(desc(altura_de_poste))

tarifa_moto <- sum(Moto$factura) / uso_Moto
################################################################Moto



total_facturado <- total_factura_camion + total_factura_Moto + total_factura_Pickup 
total_facturado

total_costo_fijo <- total_costofijo_camion+total_costofijo_Moto+total_costofijo_Pickup
total_costo_fijo

total_costo_directo <- total_costodirecto_camion+total_costodirecto_Moto+total_costodirecto_Pickup
total_costo_directo


ganancia_total <- total_facturado - (total_costo_directo+total_costo_fijo)
ganancia_total



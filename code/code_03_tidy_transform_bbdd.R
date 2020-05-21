####CARGAR PAQUETES####
source("code/code_01_setup_01_libraries.R")

####CARGAR BASE####
bbdd_final<- readRDS("data/consolidado_db_macroeconomicos.rds")

###Seleccionar solo los años disponibles para Doing Business
bbdd_2016_2020<- bbdd_final %>%
  filter(Year >= 2016)

View(bbdd_2016_2020)

####CREAR VARIABLES#####
bbdd_2016_2020 <- bbdd_2016_2020 %>% mutate(log_NY.GDP.PCAP.PP.KD = log(NY.GDP.PCAP.PP.KD))

bbdd_2016_2020$SI.POV.DDAY[bbdd_2016_2020$SI.POV.DDAY == 0] <- 0.001
bbdd_2016_2020 <- bbdd_2016_2020 %>% mutate(log_SI.POV.DDAY = log(SI.POV.DDAY))

##Recodificar Region High Income
bbdd_2016_2020 <- bbdd_2016_2020 %>% mutate(Region = case_when(Economy == "Australia"     ~ "East Asia & Pacific",
                                                               Economy == "Japan"         ~ "East Asia & Pacific",
                                                               Economy == "Japan Osaka"   ~ "East Asia & Pacific",
                                                               Economy == "Japan Tokyo"   ~ "East Asia & Pacific",
                                                               Economy == "Korea, Rep."   ~ "East Asia & Pacific",
                                                               Economy == "New Zealand"   ~ "East Asia & Pacific",
                                                               Economy == "Austria"       ~ "Europe & Central Asia",
                                                               Economy == "Belgium"       ~ "Europe & Central Asia",
                                                               Economy == "Czech Republic"~ "Europe & Central Asia",
                                                               Economy == "Denmark"       ~ "Europe & Central Asia",
                                                               Economy == "Estonia"       ~ "Europe & Central Asia",
                                                               Economy == "Finland"       ~ "Europe & Central Asia",
                                                               Economy == "France"        ~ "Europe & Central Asia", 
                                                               Economy == "Germany"       ~ "Europe & Central Asia",
                                                               Economy == "Greece"        ~ "Europe & Central Asia",
                                                               Economy == "Hungary"       ~ "Europe & Central Asia",
                                                               Economy == "Iceland"       ~ "Europe & Central Asia",
                                                               Economy == "Ireland"       ~ "Europe & Central Asia",
                                                               Economy == "Italy"         ~ "Europe & Central Asia",
                                                               Economy == "Latvia"        ~ "Europe & Central Asia",
                                                               Economy == "Lithuania"     ~ "Europe & Central Asia",
                                                               Economy == "Luxembourg"    ~ "Europe & Central Asia",
                                                               Economy == "Netherlands"   ~ "Europe & Central Asia",
                                                               Economy == "Norway"        ~ "Europe & Central Asia", 
                                                               Economy == "Poland"         ~ "Europe & Central Asia",
                                                               Economy == "Portugal"       ~ "Europe & Central Asia",
                                                               Economy == "Slovak Republic"~ "Europe & Central Asia",
                                                               Economy == "Slovenia"       ~ "Europe & Central Asia",
                                                               Economy == "Spain"          ~ "Europe & Central Asia",
                                                               Economy == "Sweden"         ~ "Europe & Central Asia",
                                                               Economy == "Switzerland"    ~ "Europe & Central Asia",
                                                               Economy == "United Kingdom" ~ "Europe & Central Asia",
                                                               Economy == "Chile"          ~ "Latin America & Caribbean",
                                                               Economy == "Israel"         ~ "Middle East & North Africa",
                                                               Economy == "Canada"                      ~ "North america",
                                                               Economy == "United States"               ~ "North america",
                                                               Economy == "United States Los Angeles"   ~ "North america",
                                                               Economy == "United States New York City" ~ "North america",
                                                               TRUE ~ Region))

table(bbdd_2016_2020$Region)
####GUARDAR BASE#####
saveRDS(object = bbdd_2016_2020, file = "data/base_final_2016_2020.rds")


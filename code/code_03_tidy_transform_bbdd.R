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
bbdd_2016_2020 <- bbdd_2016_2020 %>% mutate(log_SI.POV.DDAY = log(SI.POV.DDAY))

####GUARDAR BASE#####
saveRDS(object = bbdd_2016_2020, file = "data/base_final_2016_2020.rds")


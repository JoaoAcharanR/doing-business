####CARGAR PAQUETES####
source("code/code_01_setup_01_libraries.R")

####CARGAR BASE####
bbdd_2016_2020<- readRDS("data/base_final_2016_2020.rds")

####CARGAR REGRESIONES OLS####
source("code/code_05_regresions_OLS.R")

####MODELO MINIMOS CUADRADOS GENERALIZADOS#####
#####PIB#####
modelo_pib_orcutt<-cochrane.orcutt(modelo_pib) 
summary(modelo_pib_orcutt)
resettest(modelo_pib_orcutt)

modelo_pib_economia_sinregion_robust_orcutt <- cochrane.orcutt(modelo_pib_indicadores_sinregion)
summary(modelo_pib_economia_sinregion_robust_orcutt)
resettest(modelo_pib_economia_sinregion_robust_orcutt)

#####GINI#####
modelo_gini_db_orcutt <- cochrane.orcutt(modelo_gini_db)
summary(modelo_gini_db_orcutt)
resettest(modelo_gini_db_orcutt)

modelo_gini_economia_orcutt <- cochrane.orcutt(modelo_gini_economia)
summary(modelo_gini_economia_orcutt)
resettest(modelo_gini_economia_orcutt)

######PARTICIPACION EN EL INGRESO######
modelo_participacion_sinregion_orcutt <- cochrane.orcutt(modelo_participacion_sinregion)
summary(modelo_participacion_sinregion_orcutt)
resettest(modelo_participacion_sinregion_orcutt)

modelo_participacion_indicadores_sinregion_orcutt <- cochrane.orcutt(modelo_participacion_indicadores_sinregion)
summary(modelo_participacion_indicadores_sinregion_orcutt)
resettest(modelo_participacion_indicadores_sinregion_orcutt)

######INCIDENCIA POBREZA#####
modelo_incidencia_pobreza_sinregion_orcutt <- cochrane.orcutt(modelo_incidencia_pobreza_sinregion)
summary(modelo_incidencia_pobreza_sinregion_orcutt)
resettest(modelo_incidencia_pobreza_sinregion_orcutt)

modelo_incidencia_pobreza_indicadores_sinregion_orcutt <- cochrane.orcutt(modelo_incidencia_pobreza_indicadores_sinregion)
summary(modelo_incidencia_pobreza_indicadores_sinregion_orcutt)
resettest(modelo_incidencia_pobreza_indicadores_sinregion_orcutt)

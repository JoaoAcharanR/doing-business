####CARGAR PAQUETES####
source("code/code_01_setup_01_libraries.R")

####CARGAR BASE####
bbdd_2016_2020<- readRDS("data/base_final_2016_2020.rds")

####CARGAR REGRESIONES OLS####
source("code/code_05_regresions_OLS.R")

####CARGAR REGRESIONES OLS####
source("code/code_07_regresiones_GLS.R")

####SUPUESTOS OLS#####
#####Validación condiciones paa regresión lineal#####
#Distribución normal de los residuos Orcutt
shapiro.test(modelo_pib_orcutt$residuals)
shapiro.test(modelo_gini_db_orcutt$residuals)
shapiro.test(modelo_participacion_sinregion_orcutt$residuals)
shapiro.test(modelo_incidencia_pobreza_sinregion_orcutt$residuals)

shapiro.test(modelo_pib_economia_sinregion_robust_orcutt$residuals)
shapiro.test(modelo_gini_economia_orcutt$residuals)
shapiro.test(modelo_participacion_indicadores_sinregion_orcutt$residuals)
shapiro.test(modelo_incidencia_pobreza_indicadores_sinregion_orcutt$residuals)

#Homocedasticidad Orcutt

bptest(modelo_pib_orcutt)
bptest(modelo_gini_db_orcutt)
bptest(modelo_participacion_sinregion_orcutt)
bptest(modelo_incidencia_pobreza_sinregion_orcutt)

bptest(modelo_pib_economia_sinregion_robust_orcutt)
bptest(modelo_gini_economia_orcutt)
bptest(modelo_participacion_indicadores_sinregion_orcutt)
bptest(modelo_incidencia_pobreza_indicadores_sinregion_orcutt)

#Relación lineal entre los predictores numéricos y la variable respuesta:

plot(y=modelo_pib_orcutt$residuals,x=modelo_pib_orcutt$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)  #si residuos muestran patron, entonces forma funcional no es lineal

plot(y=modelo_gini_db_orcutt$residuals,x=modelo_gini_db_orcutt$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)  #NO HAY PATRON

plot(y=modelo_participacion_sinregion_orcutt$residuals,x=modelo_participacion_sinregion_orcutt$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)

plot(y=modelo_incidencia_pobreza_sinregion_orcutt$residuals,x=modelo_incidencia_pobreza_sinregion_orcutt$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)


plot(y=modelo_pib_economia_sinregion_robust_orcutt$residuals,x=modelo_pib_economia_sinregion_robust_orcutt$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)

plot(y=modelo_gini_economia_orcutt$residuals,x=modelo_gini_economia_orcutt$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)

plot(y=modelo_participacion_indicadores_sinregion_orcutt$residuals,x=modelo_participacion_indicadores_sinregion_orcutt$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)

plot(y=modelo_incidencia_pobreza_indicadores_sinregion_orcutt$residuals,x=modelo_incidencia_pobreza_indicadores_sinregion_orcutt$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)

####CARGAR PAQUETES####
source("code/code_01_setup_01_libraries.R")

####CARGAR BASE####
bbdd_2016_2020<- readRDS("data/base_final_2016_2020.rds")

####CARGAR REGRESIONES####
source("code/code_05_regresions_OLS.R")

####SUPUESTOS OLS#####
#####Validación condiciones paa regresión lineal#####
#Distribución normal de los residuos
shapiro.test(modelo_pib$residuals) #Mayor 0,05 No se rechaza hipotesis nula de que residuos distribuyen normal
shapiro.test(modelo_gini_db$residuals)
shapiro.test(modelo_participacion_sinregion$residuals) #Errores no distribuyen normal
shapiro.test(modelo_incidencia_pobreza_sinregion$residuals) #Errores no distribuyen normal

shapiro.test(modelo_pib_indicadores_sinregion$residuals) 
shapiro.test(modelo_gini_economia$residuals)
shapiro.test(modelo_participacion_indicadores_sinregion$residuals)
shapiro.test(modelo_incidencia_pobreza_indicadores_sinregion$residuals) #Errores no distribuyen normal

#Homocedasticidad: variabilidad constante de residuos

bptest(modelo_pib) #Se rechaza hipotesis nula de que no existe heterocedasticidad. Existe heterocedasticidad
bptest(modelo_gini_db) #No existe heterocedasticidad
bptest(modelo_participacion_sinregion) #No existe heterocedasticidad
bptest(modelo_incidencia_pobreza_sinregion) #Existe heterocedasticidad

bptest(modelo_pib_indicadores_sinregion) #Existe heterocedasticidad
bptest(modelo_gini_economia) #No existe heterocedasticidad
bptest(modelo_participacion_indicadores_sinregion) #No existe heterocedasticidad
bptest(modelo_incidencia_pobreza_indicadores_sinregion) #Existe heterocedasticidad

##Autocorrelacion
#Si el valor del estadístico Durbin Watson (DW) está próximo a 2 entonces los residuos no están autocorrelacionados. 
#Si su valor es 0 hay autocorrelación perfecta positiva. Si tiene un valor de 4 existe autocorrelación perfecta negativa.
#Valor-p debe ser superior a nivel de significancia

dwt(modelo_pib, alternative = "two.sided") #valor p ingerior a nivel de significancia y estadistico DW cercano a 0
dwt(modelo_gini_db, alternative = "two.sided") #valor p ingerior a nivel de significancia y estadistico DW cercano a 0
dwt(modelo_participacion_sinregion, alternative = "two.sided") #valor p ingerior a nivel de significancia y estadistico DW cercano a 0
dwt(modelo_incidencia_pobreza_sinregion, alternative = "two.sided") #No hay autocorrelacion

dwt(modelo_pib_indicadores_sinregion, alternative = "two.sided") #valor p ingerior a nivel de significancia y estadistico DW cercano a 0
dwt(modelo_gini_economia, alternative = "two.sided") 
dwt(modelo_participacion_indicadores_sinregion, alternative = "two.sided")
dwt(modelo_incidencia_pobreza_indicadores_sinregion,alternative = "two.sided") #No hay autocorrelacion

#Relación lineal entre los predictores numéricos y la variable respuesta:

plot(y=modelo_pib$residuals,x=modelo_pib$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)  #si residuos muestran patron, entonces forma funcional no es lineal

plot(y=modelo_gini_db$residuals,x=modelo_gini_db$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)  #NO HAY PATRON

plot(y=modelo_participacion_sinregion$residuals,x=modelo_participacion_sinregion$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)

plot(y=modelo_incidencia_pobreza_sinregion$residuals,x=modelo_incidencia_pobreza_sinregion$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)


plot(y=modelo_pib_indicadores_sinregion$residuals,x=modelo_pib_indicadores_sinregion$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)

plot(y=modelo_gini_economia$residuals,x=modelo_gini_economia$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)

plot(y=modelo_participacion_indicadores_sinregion$residuals,x=modelo_participacion_indicadores_sinregion$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)

plot(y=modelo_incidencia_pobreza_indicadores_sinregion$residuals,x=modelo_incidencia_pobreza_indicadores_sinregion$fitted.values,
     xlab="Valores Predichos",ylab="Residuos") #Si distribuyen aleatoriamente en torno a 0, todo OK
abline(0, 0)



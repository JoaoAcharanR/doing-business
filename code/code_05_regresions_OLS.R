####CARGAR PAQUETES####
source("code/code_01_setup_01_libraries.R")

####CARGAR BASE####
bbdd_2016_2020<- readRDS("data/base_final_2016_2020.rds")

####REGRESIONES OLS CON ERRORES ROBUSTOS#####
###PIB###
modelo_pib <- lm(log_NY.GDP.PCAP.PP.KD ~ `Ease of doing business score (DB17-20 methodology)` +
                   Year + Region + `Income group`, data = bbdd_2016_2020)

summary(modelo_pib)
modelo_pib_robust <- coeftest(modelo_pib, vcov. = vcovHC(modelo_pib,type="HC1"))
vif(modelo_pib) 
resettest(modelo_pib)

modelo_pib_indicadores_sinregion <- lm(log_NY.GDP.PCAP.PP.KD ~ `Score-Starting a business`+
                                      `Score-Dealing with construction permits (DB16-20 methodology)` +
                                      `Score-Getting electricity (DB16-20 methodology)`+
                                      `Score-Protecting minority investors (DB15-20 methodology)`+
                                      `Score-Trading across borders (DB16-20 methodology)`+
                                      `Score-Registering property (DB17-20 methodology)`+
                                      `Score-Getting credit (DB15-20 methodology)`+
                                      `Score-Paying taxes (DB17-20 methodology)`+
                                      `Score-Enforcing contracts (DB17-20 methodology)`+
                                      `Score-Resolving insolvency`+
                                      Year + `Income group`, data = bbdd_2016_2020)

summary(modelo_pib_indicadores_sinregion)
modelo_pib_indicadores_sinregion_robust <- coeftest(modelo_pib_indicadores_sinregion, vcov. = vcovHC(modelo_pib,type="HC1"))
vif(modelo_pib_indicadores_sinregion)
resettest(modelo_pib_indicadores_sinregion)

###GINI###
modelo_gini_db <- lm(SI.POV.GINI ~ `Ease of doing business score (DB17-20 methodology)`+
                       Year + `Income group`, data = bbdd_2016_2020)

summary(modelo_gini_db)
vif(modelo_gini_db)
resettest(modelo_gini_db)
modelo_gini_db_robust <- coeftest(modelo_gini_db, vcov. = vcovHC(modelo_gini_db,type="HC1"))

modelo_gini_economia <- lm(SI.POV.GINI ~ `Score-Starting a business`+
                             `Score-Paying taxes (DB17-20 methodology)`+
                             Year + `Income group`, data = bbdd_2016_2020)

summary(modelo_gini_economia)
vif(modelo_gini_economia)
resettest(modelo_gini_economia)
modelo_gini_economia_robust <- coeftest(modelo_gini_economia, vcov. = vcovHC(modelo_gini_economia,type="HC1"))

######PARTICIPACION EN EL INGRESO######

modelo_participacion_sinregion <- lm(SI.DST.FRST.20 ~ `Ease of doing business score (DB17-20 methodology)`+
                                       Year + `Income group`, data = bbdd_2016_2020)

summary(modelo_participacion_sinregion)
vif(modelo_participacion_sinregion)
modelo_participacion_sinregion_robust <- coeftest(modelo_participacion_sinregion, vcov. = vcovHC(modelo_participacion_sinregion,type="HC1"))
resettest(modelo_participacion_sinregion)


modelo_participacion_indicadores_sinregion <- lm(SI.DST.FRST.20 ~ `Score-Starting a business`+
                                                   `Score-Paying taxes (DB17-20 methodology)`+
                                                   Year + `Income group`, data = bbdd_2016_2020)

summary(modelo_participacion_indicadores_sinregion)
vif(modelo_participacion_indicadores_sinregion)
modelo_participacion_indicadores_sinregion_robust <- coeftest(modelo_participacion_indicadores_sinregion, vcov. = vcovHC(modelo_participacion_indicadores_sinregion,type="HC1"))
resettest(modelo_participacion_indicadores_sinregion)

######INCIDENCIA POBREZA#####
modelo_incidencia_pobreza_sinregion <- lm(log_SI.POV.DDAY ~ `Ease of doing business score (DB17-20 methodology)`+
                                            Year + `Income group`, data = bbdd_2016_2020)

summary(modelo_incidencia_pobreza_sinregion)
vif(modelo_incidencia_pobreza_sinregion)
modelo_incidencia_pobreza_sinregion_robust <- coeftest(modelo_incidencia_pobreza_sinregion, vcov. = vcovHC(modelo_incidencia_pobreza_sinregion,type="HC1"))
resettest(modelo_incidencia_pobreza_sinregion)


modelo_incidencia_pobreza_indicadores_sinregion <- lm(log_SI.POV.DDAY ~ `Score-Starting a business`+`Score-Enforcing contracts (DB17-20 methodology)`+
                                                        `Score-Registering property (DB17-20 methodology)`+ Year + `Income group`, data = bbdd_2016_2020)

summary(modelo_incidencia_pobreza_indicadores_sinregion)
vif(modelo_incidencia_pobreza_indicadores_sinregion)
resettest(modelo_incidencia_pobreza_indicadores_sinregion)
modelo_incidencia_pobreza_indicadores_sinregion_robust <- coeftest(modelo_incidencia_pobreza_indicadores_sinregion, vcov. = vcovHC(modelo_incidencia_pobreza_indicadores_sinregion,type="HC1"))


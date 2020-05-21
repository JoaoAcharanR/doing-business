####CARGAR PAQUETES####
source("code/code_01_setup_01_libraries.R")

####CARGAR BASE INDICADORES BANCO MUNDIAL####

data_cor<- read_excel("raw/Data_total.xlsx")  
View(data_cor)

####TRANSFORMAR ESTRUCTURA BBDD####
datos_1<-data_cor %>%
  pivot_longer(cols = dplyr::contains("YR"),
               names_to     = c("Year","Valor"),
               names_sep    = " ",
               values_to    = "value",
               values_ptypes = list(value = character())) %>%
  rename(country = `Country Name`,
         code = `Country Code`,
         nombre_variable = `Series Name`,
         code_variable = `Series Code`) %>%
  select(country, code, code_variable, Year, value) 


datos_1$value<- as.numeric(datos_1$value)

datos_2 <- datos_1 %>%
  pivot_wider(names_from  = code_variable,
              values_from = value)

View(datos_2)

#####UNIR BBDD CON BASE DOING BUSINESS####
data_db<- read_excel("raw/doing_bussines.xlsx", sheet="All data")  

data_db <- rename(data_db, code = "Country code",
                  Year = "DB Year")

bbdd_final <- merge(data_db,datos_2, by = c("code", "Year"), all = TRUE)

View(bbdd_final)

#####LIMPIAR BBDD#####
#Eliminar casos no pareados = todos los que en Economy son NA
bbdd_final <- bbdd_final[!is.na(bbdd_final$Economy),] #eliminar filas con valores nulos en columna Economy

##Grabar BBDD consolidada###
write_csv(bbdd_final, "data/consolidado_db_macroeconomicos.csv")
saveRDS(object = bbdd_final, file = "data/consolidado_db_macroeconomicos.rds")

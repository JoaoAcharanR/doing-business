####CARGAR PAQUETES####
source("code/code_01_setup_01_libraries.R")

####CARGAR BASE####
bbdd_2016_2020<- readRDS("data/base_final_2016_2020.rds")

####CORRELACIONES####
cor2016 <- bbdd_2016_2020 %>%
  filter(Year == 2016) %>%
  select("Ease of doing business score (DB17-20 methodology)", "Score-Starting a business",
         "Score-Dealing with construction permits (DB16-20 methodology)",
         "Score-Getting electricity (DB16-20 methodology)",
         "Score-Protecting minority investors (DB15-20 methodology)",
         "Score-Trading across borders (DB16-20 methodology)",
         "Score-Registering property (DB17-20 methodology)",
         "Score-Getting credit (DB15-20 methodology)",
         "Score-Paying taxes (DB17-20 methodology)",
         "Score-Enforcing contracts (DB17-20 methodology)",
         "Score-Resolving insolvency",
         log_SI.POV.DDAY,
         SI.DST.FRST.20,
         SI.POV.GINI,
         log_NY.GDP.PCAP.PP.KD) %>%
  chart.Correlation(histogram = TRUE,
                    pch = 19)


cor2017 <- bbdd_2016_2020 %>%
  filter(Year == 2017) %>%
  select("Ease of doing business score (DB17-20 methodology)", "Score-Starting a business",
         "Score-Dealing with construction permits (DB16-20 methodology)",
         "Score-Getting electricity (DB16-20 methodology)",
         "Score-Protecting minority investors (DB15-20 methodology)",
         "Score-Trading across borders (DB16-20 methodology)",
         "Score-Registering property (DB17-20 methodology)",
         "Score-Getting credit (DB15-20 methodology)",
         "Score-Paying taxes (DB17-20 methodology)",
         "Score-Enforcing contracts (DB17-20 methodology)",
         "Score-Resolving insolvency",
         log_SI.POV.DDAY,
         SI.DST.FRST.20,
         SI.POV.GINI,
         log_NY.GDP.PCAP.PP.KD) %>%
  chart.Correlation(histogram = TRUE,
                    pch = 19)

####Graficacion correlaciones
####PIB####
pib2016 <- bbdd_2016_2020 %>% filter(Year == 2016) %>%
  select("Ease of doing business score (DB17-20 methodology)", "Score-Starting a business",
         "Score-Dealing with construction permits (DB16-20 methodology)",
         "Score-Getting electricity (DB16-20 methodology)",
         "Score-Protecting minority investors (DB15-20 methodology)",
         "Score-Trading across borders (DB16-20 methodology)",
         "Score-Registering property (DB17-20 methodology)",
         "Score-Getting credit (DB15-20 methodology)",
         "Score-Paying taxes (DB17-20 methodology)",
         "Score-Enforcing contracts (DB17-20 methodology)",
         "Score-Resolving insolvency",log_NY.GDP.PCAP.PP.KD)

pib2016 <- pib2016 %>% dplyr::rename("Ease of doing business" = "Ease of doing business score (DB17-20 methodology)", 
                                     "Starting a business" =  "Score-Starting a business",
                                     "Dealing with construction permits" = "Score-Dealing with construction permits (DB16-20 methodology)",
                                     "Getting electricity" = "Score-Getting electricity (DB16-20 methodology)",
                                     "Protecting minority investors" = "Score-Protecting minority investors (DB15-20 methodology)",
                                     "Trading across borders" = "Score-Trading across borders (DB16-20 methodology)",
                                     "Registering property" = "Score-Registering property (DB17-20 methodology)",
                                     "Getting credit" = "Score-Getting credit (DB15-20 methodology)",
                                     "Paying taxes" = "Score-Paying taxes (DB17-20 methodology)",
                                     "Enforcing contracts" = "Score-Enforcing contracts (DB17-20 methodology)",
                                     "Resolving insolvency" = "Score-Resolving insolvency",
                                     "PIB" = log_NY.GDP.PCAP.PP.KD)

cor.matrix.pib <- round(cor(pib2016, use = "pairwise.complete.obs", method = "pearson"), digits = 2)

##Eliminar duplicados
cor.matrix.pib[2,1] <- NA
cor.matrix.pib[3,1:2] <- NA
cor.matrix.pib[4,1:3] <- NA
cor.matrix.pib[5,1:4] <- NA
cor.matrix.pib[6,1:5] <- NA
cor.matrix.pib[7,1:6] <- NA
cor.matrix.pib[8,1:7] <- NA
cor.matrix.pib[9,1:8] <- NA
cor.matrix.pib[10,1:9] <- NA
cor.matrix.pib[11,1:10] <- NA
cor.matrix.pib[12,1:11] <- NA

## convertir a dataframe y ordenar factores
cor.pib <- melt(cor.matrix.pib)
cor.pib <- cor.pib[-which(is.na(cor.pib[, 3])),]
cor.pib <- data.frame(cor.pib)
cor.pib <- cor.pib %>% mutate(X1 = X1 %>% str_wrap(15))
cor.pib <- cor.pib %>% mutate(X2 = X2 %>% str_wrap(15))

cor.pib$X2 <- as.factor(cor.pib$X2)
cor.pib$X1 <- as.factor(cor.pib$X1)

cor.pib$X2 <- factor(cor.pib$X2, levels = levels(cor.pib$X2)[c(2,11,1,5,8,12,9,4,6,3,10,7)])
cor.pib$X1 <- factor(cor.pib$X1, levels = levels(cor.pib$X1)[c(2,11,1,5,8,12,9,4,6,3,10,7)])

#Plot

plot.pib <- cor.pib  %>% ggplot(aes(fct_rev(X2), X1, fill = value))
plot.pib <- plot.pib %+% geom_tile()
plot.pib <- plot.pib %+% geom_text(aes(fct_rev(X2), X1, label = value), color = "#073642", size = 4)
plot.pib <- plot.pib %+% scale_fill_gradient(name=expression("Pearson" * ~ rho), low = "#fdf6e3", high = "steelblue",
                                             breaks=seq(0, 1, by = 0.2), limits = c(0.3, 1))
plot.pib <- plot.pib %+% scale_x_discrete(expand = c(0, 0))
plot.pib <- plot.pib %+% scale_y_discrete(expand = c(0, 0))
plot.pib <- plot.pib %+% guides(fill = guide_colorbar(barwidth = 7, barheight = 1, title.position = "top", title.hjust = 0.5))
plot.pib <- plot.pib %+% theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
plot.pib <- plot.pib %+% theme(panel.grid.major = element_blank()) 
plot.pib <- plot.pib %+% theme(panel.border = element_blank())
plot.pib <- plot.pib %+% theme(panel.background = element_blank())  
plot.pib <- plot.pib %+% theme(axis.ticks = element_blank())
plot.pib <- plot.pib %+% theme(legend.justification = c(1, 0))
plot.pib <- plot.pib %+% theme(legend.position = c(0.9, 0.7))
plot.pib <- plot.pib %+% theme(legend.direction = "horizontal")
plot.pib <- plot.pib %+% theme(axis.title.x = element_blank())
plot.pib <- plot.pib %+% theme(axis.title.y = element_blank())
plot.pib <- plot.pib %+% theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5))
plot.pib <- plot.pib %+% labs(title = "Correlaciones Indicadores\nDoing Business y PIB para año 2016")
plot.pib <- plot.pib %+% labs(caption = "Realizado por Joao Acharán")
plot.pib

ggsave("plot/plot.pib.jpg", plot = plot.pib, width = 10, height = 6)

####GINI####
gini2016 <- bbdd_2016_2020 %>% filter(Year == 2016) %>%
  select("Ease of doing business score (DB17-20 methodology)", "Score-Starting a business",
         "Score-Dealing with construction permits (DB16-20 methodology)",
         "Score-Getting electricity (DB16-20 methodology)",
         "Score-Protecting minority investors (DB15-20 methodology)",
         "Score-Trading across borders (DB16-20 methodology)",
         "Score-Registering property (DB17-20 methodology)",
         "Score-Getting credit (DB15-20 methodology)",
         "Score-Paying taxes (DB17-20 methodology)",
         "Score-Enforcing contracts (DB17-20 methodology)",
         "Score-Resolving insolvency",SI.POV.GINI)

gini2016 <- gini2016 %>% dplyr::rename("Ease of doing business" = "Ease of doing business score (DB17-20 methodology)", 
                                     "Starting a business" =  "Score-Starting a business",
                                     "Dealing with construction permits" = "Score-Dealing with construction permits (DB16-20 methodology)",
                                     "Getting electricity" = "Score-Getting electricity (DB16-20 methodology)",
                                     "Protecting minority investors" = "Score-Protecting minority investors (DB15-20 methodology)",
                                     "Trading across borders" = "Score-Trading across borders (DB16-20 methodology)",
                                     "Registering property" = "Score-Registering property (DB17-20 methodology)",
                                     "Getting credit" = "Score-Getting credit (DB15-20 methodology)",
                                     "Paying taxes" = "Score-Paying taxes (DB17-20 methodology)",
                                     "Enforcing contracts" = "Score-Enforcing contracts (DB17-20 methodology)",
                                     "Resolving insolvency" = "Score-Resolving insolvency",
                                     "Índice GINI" = SI.POV.GINI)

cor.matrix.gini <- round(cor(gini2016, use = "pairwise.complete.obs", method = "pearson"), digits = 2)

##Eliminar duplicados
cor.matrix.gini[2,1] <- NA
cor.matrix.gini[3,1:2] <- NA
cor.matrix.gini[4,1:3] <- NA
cor.matrix.gini[5,1:4] <- NA
cor.matrix.gini[6,1:5] <- NA
cor.matrix.gini[7,1:6] <- NA
cor.matrix.gini[8,1:7] <- NA
cor.matrix.gini[9,1:8] <- NA
cor.matrix.gini[10,1:9] <- NA
cor.matrix.gini[11,1:10] <- NA
cor.matrix.gini[12,1:11] <- NA

## convertir a dataframe y ordenar factores
cor.gini <- melt(cor.matrix.gini)
cor.gini <- cor.gini[-which(is.na(cor.gini[, 3])),]
cor.gini <- data.frame(cor.gini)
cor.gini <- cor.gini %>% mutate(X1 = X1 %>% str_wrap(15))
cor.gini <- cor.gini %>% mutate(X2 = X2 %>% str_wrap(15))

cor.gini$X2 <- as.factor(cor.gini$X2)
cor.gini$X1 <- as.factor(cor.gini$X1)

cor.gini$X2 <- factor(cor.gini$X2, levels = levels(cor.gini$X2)[c(2,11,1,5,8,12,9,4,7,3,10,6)])
cor.gini$X1 <- factor(cor.gini$X1, levels = levels(cor.gini$X1)[c(2,11,1,5,8,12,9,4,7,3,10,6)])

#Plot

plot.gini <- cor.gini  %>% ggplot(aes(fct_rev(X2), X1, fill = value))
plot.gini <- plot.gini %+% geom_tile()
plot.gini <- plot.gini %+% geom_text(aes(fct_rev(X2), X1, label = value), color = "#073642", size = 4)
plot.gini <- plot.gini %+% scale_fill_gradient(name=expression("Pearson" * ~ rho),low = "#fdf6e3", high = "steelblue",
                                             breaks=seq(-1, 1, by = 0.2), limits = c(-1, 1))
plot.gini <- plot.gini %+% scale_x_discrete(expand = c(0, 0))
plot.gini <- plot.gini %+% scale_y_discrete(expand = c(0, 0))
plot.gini <- plot.gini %+% guides(fill = guide_colorbar(barwidth = 12, barheight = 1, title.position = "top", title.hjust = 0.5))
plot.gini <- plot.gini %+% theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
plot.gini <- plot.gini %+% theme(panel.grid.major = element_blank()) 
plot.gini <- plot.gini %+% theme(panel.border = element_blank())
plot.gini <- plot.gini %+% theme(panel.background = element_blank())  
plot.gini <- plot.gini %+% theme(axis.ticks = element_blank())
plot.gini <- plot.gini %+% theme(legend.justification = c(1, 0))
plot.gini <- plot.gini %+% theme(legend.position = c(0.9, 0.7))
plot.gini <- plot.gini %+% theme(legend.direction = "horizontal")
plot.gini <- plot.gini %+% theme(axis.title.x = element_blank())
plot.gini <- plot.gini %+% theme(axis.title.y = element_blank())
plot.gini <- plot.gini %+% theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5))
plot.gini <- plot.gini %+% labs(title = "Correlaciones Indicadores\nDoing Business e Índice GINI para año 2016")
plot.gini <- plot.gini %+% labs(caption = "Realizado por Joao Acharán")
plot.gini

ggsave("plot/plot.gini.jpg", plot = plot.gini, width = 10, height = 6)

######PARTICIPACION EN EL INGRESO######

ingreso2016 <- bbdd_2016_2020 %>% filter(Year == 2016) %>%
  select("Ease of doing business score (DB17-20 methodology)", "Score-Starting a business",
         "Score-Dealing with construction permits (DB16-20 methodology)",
         "Score-Getting electricity (DB16-20 methodology)",
         "Score-Protecting minority investors (DB15-20 methodology)",
         "Score-Trading across borders (DB16-20 methodology)",
         "Score-Registering property (DB17-20 methodology)",
         "Score-Getting credit (DB15-20 methodology)",
         "Score-Paying taxes (DB17-20 methodology)",
         "Score-Enforcing contracts (DB17-20 methodology)",
         "Score-Resolving insolvency",SI.DST.FRST.20)

ingreso2016 <- ingreso2016 %>% dplyr::rename("Ease of doing business" = "Ease of doing business score (DB17-20 methodology)", 
                                       "Starting a business" =  "Score-Starting a business",
                                       "Dealing with construction permits" = "Score-Dealing with construction permits (DB16-20 methodology)",
                                       "Getting electricity" = "Score-Getting electricity (DB16-20 methodology)",
                                       "Protecting minority investors" = "Score-Protecting minority investors (DB15-20 methodology)",
                                       "Trading across borders" = "Score-Trading across borders (DB16-20 methodology)",
                                       "Registering property" = "Score-Registering property (DB17-20 methodology)",
                                       "Getting credit" = "Score-Getting credit (DB15-20 methodology)",
                                       "Paying taxes" = "Score-Paying taxes (DB17-20 methodology)",
                                       "Enforcing contracts" = "Score-Enforcing contracts (DB17-20 methodology)",
                                       "Resolving insolvency" = "Score-Resolving insolvency",
                                       "Participación Ingresos 20% más pobre" = SI.DST.FRST.20)

cor.matrix.ingreso <- round(cor(ingreso2016, use = "pairwise.complete.obs", method = "pearson"), digits = 2)

##Eliminar duplicados
cor.matrix.ingreso[2,1] <- NA
cor.matrix.ingreso[3,1:2] <- NA
cor.matrix.ingreso[4,1:3] <- NA
cor.matrix.ingreso[5,1:4] <- NA
cor.matrix.ingreso[6,1:5] <- NA
cor.matrix.ingreso[7,1:6] <- NA
cor.matrix.ingreso[8,1:7] <- NA
cor.matrix.ingreso[9,1:8] <- NA
cor.matrix.ingreso[10,1:9] <- NA
cor.matrix.ingreso[11,1:10] <- NA
cor.matrix.ingreso[12,1:11] <- NA

## convertir a dataframe y ordenar factores
cor.ingreso <- melt(cor.matrix.ingreso)
cor.ingreso <- cor.ingreso[-which(is.na(cor.ingreso[, 3])),]
cor.ingreso <- data.frame(cor.ingreso)
cor.ingreso <- cor.ingreso %>% mutate(X1 = X1 %>% str_wrap(15))
cor.ingreso <- cor.ingreso %>% mutate(X2 = X2 %>% str_wrap(15))

cor.ingreso$X2 <- as.factor(cor.ingreso$X2)
cor.ingreso$X1 <- as.factor(cor.ingreso$X1)

cor.ingreso$X2 <- factor(cor.ingreso$X2, levels = levels(cor.ingreso$X2)[c(2,11,1,5,8,12,9,4,7,3,10,6)])
cor.ingreso$X1 <- factor(cor.ingreso$X1, levels = levels(cor.ingreso$X1)[c(2,11,1,5,8,12,9,4,7,3,10,6)])

#Plot

plot.ingreso <- cor.ingreso  %>% ggplot(aes(fct_rev(X2), X1, fill = value))
plot.ingreso <- plot.ingreso %+% geom_tile()
plot.ingreso <- plot.ingreso %+% geom_text(aes(fct_rev(X2), X1, label = value), color = "#073642", size = 4)
plot.ingreso <- plot.ingreso %+% scale_fill_gradient(name=expression("Pearson" * ~ rho),low = "#fdf6e3", high = "steelblue",
                                               breaks=seq(-1, 1, by = 0.2), limits = c(-1, 1))
plot.ingreso <- plot.ingreso %+% scale_x_discrete(expand = c(0, 0))
plot.ingreso <- plot.ingreso %+% scale_y_discrete(expand = c(0, 0))
plot.ingreso <- plot.ingreso %+% guides(fill = guide_colorbar(barwidth = 12, barheight = 1, title.position = "top", title.hjust = 0.5))
plot.ingreso <- plot.ingreso %+% theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
plot.ingreso <- plot.ingreso %+% theme(panel.grid.major = element_blank()) 
plot.ingreso <- plot.ingreso %+% theme(panel.border = element_blank())
plot.ingreso <- plot.ingreso %+% theme(panel.background = element_blank())  
plot.ingreso <- plot.ingreso %+% theme(axis.ticks = element_blank())
plot.ingreso <- plot.ingreso %+% theme(legend.justification = c(1, 0))
plot.ingreso <- plot.ingreso %+% theme(legend.position = c(0.9, 0.7))
plot.ingreso <- plot.ingreso %+% theme(legend.direction = "horizontal")
plot.ingreso <- plot.ingreso %+% theme(axis.title.x = element_blank())
plot.ingreso <- plot.ingreso %+% theme(axis.title.y = element_blank())
plot.ingreso <- plot.ingreso %+% theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5))
plot.ingreso <- plot.ingreso %+% labs(title = "Correlaciones Indicadores\nDoing Business y participación en el ingreso\ndel 20% peor remunerado para año 2016")
plot.ingreso <- plot.ingreso %+% labs(caption = "Realizado por Joao Acharán")
plot.ingreso

ggsave("plot/plot.ingreso.jpg", plot = plot.ingreso, width = 10, height = 6)

######INCIDENCIA POBREZA#####
pobreza2016 <- bbdd_2016_2020 %>% filter(Year == 2016) %>%
  select("Ease of doing business score (DB17-20 methodology)", "Score-Starting a business",
         "Score-Dealing with construction permits (DB16-20 methodology)",
         "Score-Getting electricity (DB16-20 methodology)",
         "Score-Protecting minority investors (DB15-20 methodology)",
         "Score-Trading across borders (DB16-20 methodology)",
         "Score-Registering property (DB17-20 methodology)",
         "Score-Getting credit (DB15-20 methodology)",
         "Score-Paying taxes (DB17-20 methodology)",
         "Score-Enforcing contracts (DB17-20 methodology)",
         "Score-Resolving insolvency",log_SI.POV.DDAY)

pobreza2016 <- pobreza2016 %>% dplyr::rename("Ease of doing business" = "Ease of doing business score (DB17-20 methodology)", 
                                             "Starting a business" =  "Score-Starting a business",
                                             "Dealing with construction permits" = "Score-Dealing with construction permits (DB16-20 methodology)",
                                             "Getting electricity" = "Score-Getting electricity (DB16-20 methodology)",
                                             "Protecting minority investors" = "Score-Protecting minority investors (DB15-20 methodology)",
                                             "Trading across borders" = "Score-Trading across borders (DB16-20 methodology)",
                                             "Registering property" = "Score-Registering property (DB17-20 methodology)",
                                             "Getting credit" = "Score-Getting credit (DB15-20 methodology)",
                                             "Paying taxes" = "Score-Paying taxes (DB17-20 methodology)",
                                             "Enforcing contracts" = "Score-Enforcing contracts (DB17-20 methodology)",
                                             "Resolving insolvency" = "Score-Resolving insolvency",
                                             "Tasa incidencia de pobreza" = log_SI.POV.DDAY)

cor.matrix.pobreza <- round(cor(pobreza2016, use = "pairwise.complete.obs", method = "pearson"), digits = 2)

##Eliminar duplicados
cor.matrix.pobreza[2,1] <- NA
cor.matrix.pobreza[3,1:2] <- NA
cor.matrix.pobreza[4,1:3] <- NA
cor.matrix.pobreza[5,1:4] <- NA
cor.matrix.pobreza[6,1:5] <- NA
cor.matrix.pobreza[7,1:6] <- NA
cor.matrix.pobreza[8,1:7] <- NA
cor.matrix.pobreza[9,1:8] <- NA
cor.matrix.pobreza[10,1:9] <- NA
cor.matrix.pobreza[11,1:10] <- NA
cor.matrix.pobreza[12,1:11] <- NA

## convertir a dataframe y ordenar factores
cor.pobreza <- melt(cor.matrix.pobreza)
cor.pobreza <- cor.pobreza[-which(is.na(cor.pobreza[, 3])),]
cor.pobreza <- data.frame(cor.pobreza)
cor.pobreza <- cor.pobreza %>% mutate(X1 = X1 %>% str_wrap(15))
cor.pobreza <- cor.pobreza %>% mutate(X2 = X2 %>% str_wrap(15))

cor.pobreza$X2 <- as.factor(cor.pobreza$X2)
cor.pobreza$X1 <- as.factor(cor.pobreza$X1)

cor.pobreza$X2 <- factor(cor.pobreza$X2, levels = levels(cor.pobreza$X2)[c(2,10,1,5,7,12,8,4,6,3,9,11)])
cor.pobreza$X1 <- factor(cor.pobreza$X1, levels = levels(cor.pobreza$X1)[c(2,10,1,5,7,12,8,4,6,3,9,11)])

#Plot

plot.pobreza <- cor.pobreza  %>% ggplot(aes(fct_rev(X2), X1, fill = value))
plot.pobreza <- plot.pobreza %+% geom_tile()
plot.pobreza <- plot.pobreza %+% geom_text(aes(fct_rev(X2), X1, label = value), color = "#073642", size = 4)
plot.pobreza <- plot.pobreza %+% scale_fill_gradient(name=expression("Pearson" * ~ rho),low = "#fdf6e3", high = "steelblue",
                                                     breaks=seq(-1, 1, by = 0.2), limits = c(-1, 1))
plot.pobreza <- plot.pobreza %+% scale_x_discrete(expand = c(0, 0))
plot.pobreza <- plot.pobreza %+% scale_y_discrete(expand = c(0, 0))
plot.pobreza <- plot.pobreza %+% guides(fill = guide_colorbar(barwidth = 12, barheight = 1, title.position = "top", title.hjust = 0.5))
plot.pobreza <- plot.pobreza %+% theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
plot.pobreza <- plot.pobreza %+% theme(panel.grid.major = element_blank()) 
plot.pobreza <- plot.pobreza %+% theme(panel.border = element_blank())
plot.pobreza <- plot.pobreza %+% theme(panel.background = element_blank())  
plot.pobreza <- plot.pobreza %+% theme(axis.ticks = element_blank())
plot.pobreza <- plot.pobreza %+% theme(legend.justification = c(1, 0))
plot.pobreza <- plot.pobreza %+% theme(legend.position = c(0.9, 0.7))
plot.pobreza <- plot.pobreza %+% theme(legend.direction = "horizontal")
plot.pobreza <- plot.pobreza %+% theme(axis.title.x = element_blank())
plot.pobreza <- plot.pobreza %+% theme(axis.title.y = element_blank())
plot.pobreza <- plot.pobreza %+% theme(plot.title = element_text(size = 10, face = "bold", hjust = 0.5))
plot.pobreza <- plot.pobreza %+% labs(title = "Correlaciones Indicadores\nDoing Business y Tasa de incidencia\nde la pobreza para año 2016")
plot.pobreza <- plot.pobreza %+% labs(caption = "Realizado por Joao Acharán")
plot.pobreza

ggsave("plot/plot.pobreza.jpg", plot = plot.pobreza, width = 10, height = 6)

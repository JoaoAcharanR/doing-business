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


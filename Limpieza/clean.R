library(googlesheets4)
library(tidyverse)

url <- "https://docs.google.com/spreadsheets/d/1i2dDrX_CpXSx22tlPQQna0i86_vde7dnO1bq7phQEFE/edit?resourcekey&usp=forms_web_b#gid=51359133"
data <- read_sheet(url, col_names = F, skip = 1)

#Nombres
names <- c("temporal","licenciatura","edad","genero","estado","areas",
           "seguridad","privacidad","huella","dispositivos",
           "dispositivos_cantidad","ordena_compu","ordena_tablet",
           "ordena_celular","ordena_smart","ordena_otro","configuracion",
           "antivirus","actualizacion","sociales_contar","sociales_cuales",
           "ordena_facebook","ordena_instagram","ordena_whatsapp",
           "ordena_twitter","ordena_tiktok","ordena_ninguna" ,"ordena_otra",
           "banca","compras_online","paypal","term_cond","cookies",
           "cookies_accesibles","publicidad","cargos","victima","con_victima",
           "evitado","proteccion","navegador","url","phishing","datos",
           "empresas","preocupacion_empresas","username")

names(data) <- names
id <- 1:nrow(data)

data <- cbind(id, data)

#Unnest
data<-
    data %>%
    mutate(dispositivos_cantidad = strsplit(dispositivos_cantidad, ",")) %>%
    unnest(dispositivos_cantidad) %>%
    mutate(sociales_cuales = strsplit(sociales_cuales, ",")) %>%
    unnest(sociales_cuales) %>%
    mutate(victima = strsplit(victima, ",")) %>%
    unnest(victima) %>%
    mutate(proteccion = strsplit(proteccion, ",")) %>%
    unnest(proteccion)

#Demográficos
demograficos <-
    data %>%
    select(id, temporal, licenciatura, edad, genero, estado, areas) %>%
    distinct(id, .keep_all = T) %>%
    rename(id_demograficos = id)

#Exploratorias
exploratorias <-
    data %>%
    select(id, seguridad, privacidad, huella) %>%
    distinct(id, .keep_all = T) %>%
    rename(id_demograficos = id)
exploratorias$id_exploratorias <- 1:nrow(exploratorias)

#Vulnerabilidad
vulnerabilidad <- 
    data %>%
    select(id, dispositivos, ordena_compu,  ordena_tablet, ordena_celular,
           ordena_smart, ordena_otro, configuracion, antivirus, 
           actualizacion) %>% 
    distinct(id, .keep_all = T) %>%
    rename(id_demograficos = id)
vulnerabilidad$id_vulnerabilidad <- 1:nrow(vulnerabilidad)

dispositivos_cuales <-
    data %>%
    select(id, dispositivos_cantidad) %>%
    distinct(id,dispositivos_cantidad) %>%
    rename(id_vulnerabilidad = id)
dispositivos_cuales$id_dispositivos_cuales <- 1:nrow(dispositivos_cuales)

#Redes sociales
redes_sociales <-
    data %>%
    select(id, sociales_contar, ordena_facebook, ordena_instagram, 
           ordena_whatsapp, ordena_twitter, ordena_tiktok, ordena_ninguna,
           ordena_otra) %>%
    distinct(id, .keep_all = T) %>%
    rename(id_demograficos = id)
redes_sociales$id_redes_sociales <- 1:nrow(redes_sociales)

sociales_cuales <-
    data %>%
    select(id, sociales_cuales) %>%
    distinct(id, sociales_cuales) %>%
    rename(id_redes_sociales = id)
sociales_cuales$id_sociales_cuales <- 1:nrow(sociales_cuales)

#Prevención digitales
prevencion_digital <-
    data %>%
    select(id, banca, compras_online, paypal, term_cond, cookies,
           cookies_accesibles, publicidad, cargos, con_victima, evitado) %>%
    distinct(id, .keep_all = T) %>%
    rename(id_demograficos = id)
prevencion_digital$id_prevencion_digital <- 1:nrow(prevencion_digital)

victima <-
    data %>%
    select(id, victima) %>%
    distinct(id, victima) %>%
    rename(id_prevencion_digital = id)
victima$id_victima <- 1:nrow(victima)

proteccion <-
    data %>%
    select(id, proteccion) %>%
    distinct(id, proteccion) %>%
    rename(id_prevencion_digital = id)
proteccion$id_proteccion <- 1:nrow(proteccion)

#Prevencion navegacion
prevencion_navegacion <-
    data %>%
    select(id, navegador, url, phishing) %>%
    distinct(id, .keep_all = T) %>%
    rename(id_demograficos = id)
prevencion_navegacion$id_prevencion_navegacion <- 1:nrow(prevencion_navegacion)

#Manejo informacion
manejo_info <-
    data %>%
    select(id, datos, empresas, preocupacion_empresas, username) %>%
    distinct(id, .keep_all = T) %>%
    rename(id_demograficos = id)
manejo_info$id_manejo_info <- 1:nrow(manejo_info)

#DB connection
library(RPostgreSQL)
library(getPass)
library(DBI)

driver <- dbDriver(drvName = "PostgreSQL")

db <- dbConnect(driver,
                dbname="postgres",
                host="equiposinarturo-server.eastus.cloudapp.azure.com",
                port=5432,
                user="admin",
                password = getPass("Password:"))

# db <- dbConnect(driver,
#                 dbname="postgres",
#                 host="54.161.119.17",
#                 port=5432,
#                 user="admin",
#                 password = getPass("Password:"))

if (length(dbReadTable(db,"demograficos")$id) == 0) {
    rows <- 0
} else {
    rows <- max(dbReadTable(db,"demograficos")$id)
}

fun <- 
    function(table){
        if (length(dbReadTable(db,table)[,paste0("id_",table)]) == 0) {
            return(1)
        } else {
            return(max(dbReadTable(db,table)[,paste0("id_",table)])+1)
        }
    }

if (rows != (max(data$id)-1)) {
    dbWriteTable(db, "demograficos", 
                 demograficos[fun("demograficos"):nrow(demograficos),], 
                 append=T, row.names=F)
    dbWriteTable(db, "exploratorias", 
                 exploratorias[fun("exploratorias"):nrow(exploratorias),],
                 append=T, row.names=F)
    dbWriteTable(db, "vulnerabilidad", 
                 vulnerabilidad[fun("vulnerabilidad"):nrow(vulnerabilidad),],
                 append=T, row.names=F)
    dbWriteTable(db, "dispositivos_cuales", 
                 dispositivos_cuales[fun("dispositivos_cuales"):nrow(dispositivos_cuales),], 
                 append=T, row.names=F)
    dbWriteTable(db, "redes_sociales", 
                 redes_sociales[fun("redes_sociales"):nrow(redes_sociales),], 
                 append=T, row.names=F)
    dbWriteTable(db, "sociales_cuales", 
                 sociales_cuales[fun("sociales_cuales"):nrow(sociales_cuales),], 
                 append=T, row.names=F)
    dbWriteTable(db, "prevencion_digital", 
                 prevencion_digital[fun("prevencion_digital"):nrow(prevencion_digital),], 
                 append=T, row.names=F)
    dbWriteTable(db, "victima", 
                 victima[fun("victima"):nrow(victima),],
                 append=T, row.names=F)
    dbWriteTable(db, "proteccion", 
                 proteccion[fun("proteccion"):nrow(proteccion),], 
                 append=T, row.names=F)
    dbWriteTable(db, "prevencion_navegacion", 
                 prevencion_navegacion[fun("prevencion_navegacion"):nrow(prevencion_navegacion),],
                 append=T, row.names=F)
    dbWriteTable(db, "manejo_info", 
                 manejo_info[fun("manejo_info"):nrow(manejo_info),], 
                 append=T, row.names=F)
}

dbDisconnect(db)


















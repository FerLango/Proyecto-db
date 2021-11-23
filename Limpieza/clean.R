library(googlesheets4)
library(tidyverse)

url <- "https://docs.google.com/spreadsheets/d/1pKO-J9Ud8pGiOzbnFFpj7FYusXwzu53IDrDqYqPtjlY/edit?resourcekey#gid=857297717"
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
    rename(id_vulnerabilidad = id)
vulnerabilidad$id_vulnerabilidad <- 1:nrow(vulnerabilidad)

dispositivos_cuales <-
    data %>%
    select(id, dispositivos_cantidad) %>%
    distinct(id,dispositivos_cantidad) %>%
    rename(id_demograficos = id)
dispositivos_cuales$id_dispositivos_cuales <- 1:nrow(dispositivos_cuales)

#Redes sociales
redes_sociales <-
    data %>%
    select(id, sociales_contar, ordena_facebook, ordena_instagram, 
           ordena_whatsapp, ordena_twitter, ordena_tiktok, ordena_ninguna,
           ordena_otra) %>%
    distinct(id, .keep_all = T)
redes_sociales$id_redes_sociales <- 1:nrow(redes_sociales)

sociales_cuales <-
    data %>%
    select(id, sociales_cuales) %>%
    distinct(id, sociales_cuales)
sociales_cuales$id_sociales_cuales <- 1:nrow(sociales_cuales)

#Prevención digitales
prevencion_digital <-
    data %>%
    select(id, banca, compras_online, paypal, term_cond, cookies,
           cookies_accesibles, publicidad, cargos, con_victima, evitado) %>%
    distinct(id, .keep_all = T)
prevencion_digital$id_prevencion_digital <- 1:nrow(prevencion_digital)

victima <-
    data %>%
    select(id, victima) %>%
    distinct(id, victima)
victima$id_victima <- 1:nrow(victima)

proteccion <-
    data %>%
    select(id, proteccion) %>%
    distinct(id, proteccion)
proteccion$id_proteccion <- 1:nrow(proteccion)

#Prevencion navegacion
prevencion_navegacion <-
    data %>%
    select(id, navegador, url, phishing) %>%
    distinct(id, .keep_all = T)
prevencion_navegacion$id_prevencion_navegacion <- 1:nrow(prevencion_navegacion)

#Manejo informacion
manejo_info <-
    data %>%
    select(id, datos, empresas, preocupacion_empresas, username) %>%
    distinct(id, .keep_all = T)
manejo_info$id_manejo_info <- 1:nrow(manejo_info)

#DB connection
library(RPostgreSQL)
library(getPass)
library(DBI)

driver <- dbDriver(drvName = "PostgreSQL")

db <- dbConnect(driver,
                dbname="postgres",
                host="54.161.119.17",
                port=5432,
                user="admin",
                password = getPass("Password:"))

dbWriteTable(db, "demograficos", demograficos, row.names=F, append=T)

########################################################################
dbWriteTable(db, "demograficos", demograficos, overwrite=T, row.names=F)
dbWriteTable(db, "exploratorias", exploratorias, overwrite=T, row.names=F)
dbWriteTable(db, "vulnerabilidad", vulnerabilidad, overwrite=T, row.names=F)
dbWriteTable(db, "dispositivos_cuales", dispositivos_cuales, overwrite=T, row.names=F)
dbWriteTable(db, "redes_sociales", redes_sociales, overwrite=T, row.names=F)
dbWriteTable(db, "sociales_cuales", sociales_cuales, overwrite=T, row.names=F)
dbWriteTable(db, "prevencion_digital", prevencion_digital, overwrite=T, row.names=F)
dbWriteTable(db, "victima", victima, overwrite=T, row.names=F)
dbWriteTable(db, "proteccion", proteccion, overwrite=T, row.names=F)
dbWriteTable(db, "prevencion_navegacion", prevencion_navegacion, overwrite=T, row.names=F)
dbWriteTable(db, "manejo_info", manejo_info, overwrite=T, row.names=F)

dbDisconnect(db)



demograficos2[(max(dbReadTable(db,"demograficos")$id)+1):nrow(demograficos2),]
max(dbReadTable(db,"demograficos")$id)


















# Cargamos los paquetes necesarios ------------------------------------------------------------

library(data.table)

anxiety <- fread("data-raw/raw-data.csv")
anxiety <- anxiety[, list(id, age, sex, zone, beck_global, pits_global, cat_age)]

# Tratamiento inicial -------------------------------------------------------------------------

ind = grep("^age|global", names(anxiety), value = TRUE, invert = TRUE)

anxiety[, (ind) := lapply(.SD, as.factor), .SDcols = ind][]

# Exportamos los datos ------------------------------------------------------------------------

usethis::use_data(anxiety, overwrite = TRUE)

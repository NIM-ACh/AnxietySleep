
# Cargamos los paquetes necesarios ------------------------------------------------------------

library(data.table)

anxiety = fread("data-raw/raw-data.csv")

# Tratamiento inicial -------------------------------------------------------------------------

ind = grep("^age|global|latencia|duracion", names(anxiety), value = TRUE, invert = TRUE)

anxiety[, (ind) := lapply(.SD, as.factor), .SDcols = ind][]

# Removing extreme values
anxiety[pits_latencia > 480, pits_latencia := NA]
anxiety[pits_duracion_estimada > 24 | pits_duracion_estimada < 1,
        pits_duracion_estimada := NA]

# Rounding numeric values to no more than 1 decimal place
anxiety[, pits_latencia := round(pits_latencia, 1)]
anxiety[, pits_duracion_estimada := round(pits_duracion_estimada, 1)]

# Exportamos los datos ------------------------------------------------------------------------

usethis::use_data(anxiety, overwrite = TRUE)

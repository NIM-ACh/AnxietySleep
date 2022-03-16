
# Cargamos los paquetes necesarios ------------------------------------------------------------

library(data.table)

anxiety = fread("data-raw/dataset.csv")

# Tratamiento inicial -------------------------------------------------------------------------

anxiety[, id := as.factor(id)][]

anxiety[, sex := as.factor(sex)][]

anxiety[, zone := as.factor(zone)][]

anxiety[, cat_age := as.factor(cat_age)][]

# Exportamos los datos ------------------------------------------------------------------------

usethis::use_data(anxiety, overwrite = TRUE)

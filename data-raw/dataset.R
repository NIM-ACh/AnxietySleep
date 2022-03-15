
# Cargamos los paquetes necesarios ------------------------------------------------------------

library(data.table)

dataset <- fread("data-raw/dataset.csv")

# Tratamiento inicial -------------------------------------------------------------------------

dataset[, id := as.factor(id)][]

dataset[, sex := as.factor(sex)][]

dataset[, zone := as.factor(zone)][]

dataset[, cat_age := as.factor(cat_age)][]

# Exportamos los datos ------------------------------------------------------------------------

usethis::use_data(dataset, overwrite = TRUE)

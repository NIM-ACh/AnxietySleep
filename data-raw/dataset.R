
# Cargamos los paquetes necesarios ------------------------------------------------------------

library(data.table)


# Importamos los datos ------------------------------------------------------------------------

dataset <- data.table::fread(input = "data-raw/dataset_raw.csv")


# Tratamiento inicial -------------------------------------------------------------------------

dataset[, sexo := factor(sexo, levels = 0:1, labels = c("Mujer", "Hombre"))]

dataset[, zona := factor(zona, levels = 1:2, labels = c("EC", "SC"))]

dataset[, cat_edad := factor(cat_edad, levels = c("18-25", "26-40", "41-50", ">50"))]


# Exportamos los datos ------------------------------------------------------------------------

data.table::fwrite(dataset, file = "data-raw/dataset.csv")
usethis::use_data(dataset, overwrite = TRUE)

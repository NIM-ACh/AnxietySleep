
# Información general -------------------------------------------------------------------------

## función: Crear el la figura 1 y 2 para el manuscrito
## autor: Matías Castillo Aguilar
## fecha: 03-03-2022

# Cargamos paquetes ---------------------------------------------------------------------------

library(data.table)
library(ggplot2)
library(ggside)
library(ggsci)
library(ggpubr)

# Funciones auxiliares ------------------------------------------------------------------------

dt_pipe <- `[`

# Cargamos los datos --------------------------------------------------------------------------

dataset <- AnxietySleep::dataset

# Figura 1 ------------------------------------------------------------------------------------

# Eliminamos dos valores
remove_outliers <- quote(-c(which.min(pits_global), which.max(pits_global)))

fig1 <- ggplot(data = dataset[i = eval(remove_outliers)],
               aes(x = sqrt(pits_global),
                   y = sqrt(beck_global))) +

  # Hacemos el tamaño de los puntos relativo al número de observaciones
  geom_count(shape = 21, color = "black", aes(fill = zone), show.legend = FALSE, alpha = 0.5) +

  # Usamos la paleta de colores del 'New England Journal of Medicine'
  scale_color_manual(values = pal_nejm()(2), aesthetics = c("fill", "color")) +

  # Generamos la línea de regresión LOESS
  geom_smooth(method = "loess", se = F, aes(col = zone)) +

  # Generamos las distribuciones marginales
  geom_xsideboxplot(mapping = aes(y = zone, fill = zone), orientation = "y",
                    outlier.shape = 21, outlier.alpha = .5, alpha = 0.5) +
  geom_ysideboxplot(mapping = aes(x = zone, fill = zone), orientation = "x",
                    outlier.shape = 21, outlier.alpha = .5, alpha = 0.5) +

  # Y eliminamos las etiquetas de los ejes de estas distribuciones marginales
  scale_xsidey_discrete(guide = guide_none()) +
  scale_ysidex_discrete(guide = guide_none()) +

  # Modificamos las etiquetas de los ejes
  labs(x = expression(sqrt("PSQI")),
       y = expression(sqrt("BAI")),
       col = "Confinement",
       fill = "Confinement") +

  # Añadimos un tema para mejorar la estética
  theme_linedraw(base_family = "Times",
                 base_size = 16) +

  # La leyenda la dejamos arriba del gráfico y eliminamos las lineas
  # del 'grid' del gráfico
  theme(legend.position = "top",
        panel.grid = element_blank(),
        ggside.panel.scale.x = .15,
        ggside.panel.scale.y = (.15 * 3 / 4))

# Figura 2 ------------------------------------------------------------------------------------

p1 <- ggstatsplot::ggbetweenstats(
  data = dataset, x = sex, y = beck_global,
  type = "np", xlab = "", ylab = "BAI", results.subtitle = FALSE,
  palette = "default_nejm", package = "ggsci", k = 0,
  ggtheme = theme_linedraw(base_family = "Times", base_size = 16),
  ggplot.component = list(theme(panel.grid = element_blank())))

p2 <- ggstatsplot::ggbetweenstats(
  data = dataset, x = sex, y = pits_global,
  type = "np", xlab = "Sexo", ylab = "PSQI", results.subtitle = FALSE,
  palette = "default_nejm", package = "ggsci", k = 0,
  ggtheme = theme_linedraw(base_family = "Times", base_size = 16),
  ggplot.component = list(theme(panel.grid = element_blank())))

fig2 <- ggpubr::ggarrange(p1, p2, labels = c("A.", "B."), ncol = 1, hjust = 0)

# Exportamos y guardamos el gráfico -----------------------------------------------------------

## PDF
local({
  pdf("man/figures/figure-1.pdf", width = 8, height = 6);
  print(fig1);
  dev.off();
})
local({
  pdf("man/figures/figure-2.pdf", width = 6, height = 8);
  print(fig2);
  dev.off();
})

## TIFF
local({
  tiff("man/figures/figure-1.tiff", width = 8, height = 6, units = "in", res = 600);
  print(fig1);
  dev.off();
})
local({
  tiff("man/figures/figure-2.tiff", width = 6, height = 8, units = "in", res = 600);
  print(fig2);
  dev.off();
})


# Información de la sesión --------------------------------------------------------------------

sessionInfo()

# R version 4.1.2 (2021-11-01)
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS Monterey 12.2.1
#
# Matrix products: default
# LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib
#
# locale:
#   [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
#
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base
#
# other attached packages:
#   [1] ggpubr_0.4.0      ggsci_2.9         ggside_0.2.0      ggplot2_3.3.5     data.table_1.14.2 usethis_2.1.5
#
# loaded via a namespace (and not attached):
#   [1] tidyr_1.2.0             splines_4.1.2           carData_3.0-5           paletteer_1.4.0         datawizard_0.3.0
# [6] assertthat_0.2.1        ggrepel_0.9.1           yaml_2.3.5              bayestestR_0.11.5       pillar_1.7.0
# [11] backports_1.4.1         lattice_0.20-45         glue_1.6.2              digest_0.6.29           ggsignif_0.6.3
# [16] colorspace_2.0-3        sandwich_3.0-1          cowplot_1.1.1           htmltools_0.5.2         Matrix_1.4-0
# [21] plyr_1.8.6              pkgconfig_2.0.3         broom_0.7.12.9000       purrr_0.3.4             xtable_1.8-4
# [26] mvtnorm_1.1-3           patchwork_1.1.1         scales_1.1.1            emmeans_1.7.2           tibble_3.1.6
# [31] mgcv_1.8-39             farver_2.1.0            generics_0.1.2          car_3.0-12              ellipsis_0.3.2
# [36] TH.data_1.1-0           withr_2.4.3             cli_3.2.0               effectsize_0.6.0.1      survival_3.3-0
# [41] magrittr_2.0.2          crayon_1.5.0            estimability_1.3        ggstatsplot_0.9.1       evaluate_0.15
# [46] fs_1.5.2                fansi_1.0.2             nlme_3.1-155            MASS_7.3-55             WRS2_1.1-3
# [51] rstatix_0.7.0           tools_4.1.2             lifecycle_1.0.1         multcomp_1.4-18         munsell_0.5.0
# [56] AnxietySleep_0.0.0.9000 statsExpressions_1.3.0  compiler_4.1.2          rlang_1.0.1             grid_4.1.2
# [61] rstudioapi_0.13         parameters_0.16.0       labeling_0.4.2          rmarkdown_2.12          boot_1.3-28
# [66] gtable_0.3.0            codetools_0.2-18        abind_1.4-5             DBI_1.1.2               reshape_0.8.8
# [71] rematch2_2.1.2          correlation_0.8.0       R6_2.5.1                zoo_1.8-9               knitr_1.37
# [76] dplyr_1.0.8             performance_0.8.0       fastmap_1.1.0           mc2d_0.1-21             utf8_1.2.2
# [81] zeallot_0.1.0           prismatic_1.1.0         insight_0.16.0          Rcpp_1.0.8              vctrs_0.3.8
# [86] tidyselect_1.1.2        xfun_0.30               coda_0.19-4

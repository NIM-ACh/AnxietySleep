
# Información general -------------------------------------------------------------------------

## función: Crear el la figura 1 para el manuscrito
## autor: Matías Castillo Aguilar
## fecha: 31-10-2021

# Cargamos paquetes ---------------------------------------------------------------------------

library(data.table)
library(ggplot2)
library(ggside)
library(ggsci)
library(ggpubr)

# Funciones auxiliares ------------------------------------------------------------------------

dt_pipe <- `[`

# Cargamos los datos --------------------------------------------------------------------------

data <- readRDS(file = here::here("data/clean/data_clean.RDS"))


# Figura 1 ------------------------------------------------------------------------------------

## Datos para hacer el gráfico
data_fig <- copy(data) |> 
  ## Modificamos los niveles de región a EC y SC
  dt_pipe(j = region := `levels<-`(region, c("EC", "SC"))) |> 
  ## Eliminamos valores influyentes para la regresión LOESS
  dt_pipe(i = -c(which.min(pits_global), which.max(pits_global)))

## Generamos el gráfico
fig1 <- data_fig |>
  ggplot(aes(x = sqrt(pits_global), y = sqrt(beck_global))) +
  
  ## Capa de puntos con tamaño relativo al tamaño muestral
  geom_count(shape = 21, color = "black", aes(fill = region), show.legend = F, alpha = 0.5) +
  
  ## Paleta de colores del New England Journal of Medicine (NEJM)
  scale_color_manual(values = pal_nejm()(2), aesthetics = c("fill", "color")) +
  
  ## Linea de regresieon LOESS
  geom_smooth(method = "loess", se = F, aes(group = region, col = region)) +
  
  ## Box-plots marginales 
  geom_xsideboxplot(aes(y = region, fill = region), orientation = "y", outlier.shape = 21, outlier.alpha = .5, alpha = 0.5) +
  scale_xsidey_discrete(guide = guide_none()) +
  geom_ysideboxplot(aes(x = region, fill = region), orientation = "x", outlier.shape = 21, outlier.alpha = .5, alpha = 0.5) +
  scale_ysidex_discrete(guide = guide_none()) +
  
  ## Nombres de los ejes
  labs(
    x = expression(sqrt("PSQI")),
    y = expression(sqrt("BAI")),
    col = "Confinamiento",
    fill = "Confinamiento"
  ) +
  
  ## Estilo o tema del gráfico
  theme_linedraw(
    base_family = "Times",
    base_size = 16) +
  
  ## Ajustes menores estéticos
  theme(
    legend.position = "top",
    panel.grid = element_blank(),
    aspect.ratio = 3 / 4,
    ggside.panel.scale.x = .15,
    ggside.panel.scale.y = (.15 * 3 / 4)
  )


# Figura 2 ------------------------------------------------------------------------------------

p1 <- ggstatsplot::ggbetweenstats(data, sexo, beck_global, type = "np",
                                  xlab = "", ylab = "BAI", results.subtitle = FALSE,
                                  palette = "default_nejm", package = "ggsci", k = 0,
                                  ggtheme = theme_linedraw(base_family = "Times",
                                                           base_size = 16),
                                  ggplot.component = list(
                                    theme(panel.grid = element_blank())
                                  ))

p2 <- ggstatsplot::ggbetweenstats(data, sexo, pits_global, type = "np",
                                  xlab = "Sexo", ylab = "PSQI", results.subtitle = FALSE,
                                  palette = "default_nejm", package = "ggsci", k = 0,
                                  ggtheme = theme_linedraw(base_family = "Times",
                                                           base_size = 16),
                                  ggplot.component = list(
                                    theme(panel.grid = element_blank())
                                  ))

fig2 <- ggpubr::ggarrange(p1, p2, labels = c("A.", "B."), ncol = 1, hjust = 0)

# Exportamos y guardamos el gráfico -----------------------------------------------------------

## PDF
local({
  pdf("output/figures/figure-1.pdf", width = 8, height = 6);
  print(fig1);
  dev.off();
})
local({
  pdf("output/figures/figure-2.pdf", width = 6, height = 8);
  print(fig2);
  dev.off();
})

## TIFF
local({
  tiff("output/figures/figure-1.tiff", width = 8, height = 6, units = "in", res = 600);
  print(fig1);
  dev.off();
})
local({
  tiff("output/figures/figure-2.tiff", width = 6, height = 8, units = "in", res = 600);
  print(fig2);
  dev.off();
})


# Información de la sesión --------------------------------------------------------------------

sessionInfo()

# R version 4.1.1 (2021-08-10)
# Platform: x86_64-apple-darwin17.0 (64-bit)
# Running under: macOS Big Sur 11.6
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
#   [1] ggsci_2.9         ggside_0.1.2      ggplot2_3.3.5     data.table_1.14.2
# 
# loaded via a namespace (and not attached):
#   [1] pillar_1.6.4     compiler_4.1.1   tools_4.1.1      digest_0.6.28    lattice_0.20-45  nlme_3.1-153    
# [7] evaluate_0.14    lifecycle_1.0.1  tibble_3.1.5     gtable_0.3.0     mgcv_1.8-38      pkgconfig_2.0.3 
# [13] rlang_0.4.12     Matrix_1.3-4     DBI_1.1.1        yaml_2.2.1       xfun_0.27        fastmap_1.1.0   
# [19] withr_2.4.2      dplyr_1.0.7      knitr_1.36       generics_0.1.1   vctrs_0.3.8      rprojroot_2.0.2 
# [25] grid_4.1.1       tidyselect_1.1.1 glue_1.4.2       here_1.0.1       R6_2.5.1         fansi_0.5.0     
# [31] rmarkdown_2.11   farver_2.1.0     purrr_0.3.4      magrittr_2.0.1   scales_1.1.1     ellipsis_0.3.2  
# [37] htmltools_0.5.2  splines_4.1.1    assertthat_0.2.1 colorspace_2.0-2 labeling_0.4.2   utf8_1.2.2      
# [43] munsell_0.5.0    crayon_1.4.1
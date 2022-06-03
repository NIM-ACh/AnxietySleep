# Analyses from the Alvarado-Aravena et al. (2022) study.

# Load de `anxiety` dataset
library(AnxietySleep)

library(modelbased)

# ANOVA ---------------------------------------------------------------------------------------

# BAI
aov_bai_1 <- anxiety[, aov(sqrt(beck_global) ~ zone)]
aov_bai_2 <- anxiety[, aov(sqrt(beck_global) ~ sex + zone + sex:zone)]
aov_bai_3 <- anxiety[, aov(sqrt(beck_global) ~ sex + cat_age + zone + sex:cat_age + sex:zone + cat_age:zone)]

lapply(mget(paste0("aov_bai_", 1:3)), report::report_table)

anova(aov_bai_1, aov_bai_2)
anova(aov_bai_2, aov_bai_3)

estimate_contrasts(
  model = aov_bai_2,
  contrast = c("sex", "zone"),
  adjust = "fdr"
)


# PSQI
aov_psqi_1 <- anxiety[, aov(sqrt(pits_global) ~ zone)]
aov_psqi_2 <- anxiety[, aov(sqrt(pits_global) ~ sex + zone + sex:zone)]
aov_psqi_3 <- anxiety[, aov(sqrt(pits_global) ~ sex + cat_age + zone + sex:cat_age + sex:zone + cat_age:zone)]

lapply(mget(paste0("aov_psqi_", 1:3)), report::report_table)

anova(aov_psqi_1, aov_psqi_2)
anova(aov_psqi_2, aov_psqi_3)

estimate_contrasts(
  model = aov_psqi_2,
  contrast = c("sex", "zone"),
  adjust = "fdr"
)

# Regression ----------------------------------------------------------------------------------

# BAI
mod_bai_1 <- anxiety[, lm(sqrt(beck_global) ~ sqrt(pits_global))]
mod_bai_2 <- anxiety[, lm(sqrt(beck_global) ~ sex + sqrt(pits_global))]
mod_bai_3 <- anxiety[, lm(sqrt(beck_global) ~ sex + cat_age + sqrt(pits_global))]

anova(mod_bai_1, mod_bai_2)
anova(mod_bai_1, mod_bai_3)
anova(mod_bai_2, mod_bai_3)

lapply(mget(paste0("mod_bai_", 1:3)), report::report_table)

# PSQI
mod_psqi_1 <- anxiety[, lm(sqrt(pits_global) ~ sqrt(beck_global))]
mod_psqi_2 <- anxiety[, lm(sqrt(pits_global) ~ sex + sqrt(beck_global))]
mod_psqi_3 <- anxiety[, lm(sqrt(pits_global) ~ sex + cat_age + sqrt(beck_global))]

anova(mod_psqi_1, mod_psqi_2)
anova(mod_psqi_1, mod_psqi_3)
anova(mod_psqi_2, mod_psqi_3)

lapply(mget(paste0("mod_psqi_", 1:3)), report::report_table)


# Figure 2 ------------------------------------------------------------------------------------

coefplot <- dotwhisker::dwplot(
  x = list(mod_bai_3,
           mod_psqi_3),
  vline = ggplot2::geom_vline(xintercept = 0,
                              col = "grey60",
                              lty = 2),
  dot_args = list(cex = 3, ggplot2::aes(shape = model)),
  ci = .95,
  dodge_size = .3,
)

fig <- coefplot +
  see::theme_modern(base_size = 15,
                   legend.position = "none") +
  ggplot2::scale_y_discrete(labels = c(
    "√BAI", "√PSQI", "Age [41-50]", "Age [26-40]",
    "Age [18-25]", "Sex [Male]"
  )) +
  ggplot2::scale_color_manual(
    values = ggsci::pal_jco()(2)[c(2,1)]
  ) +
  ggplot2::scale_shape_manual(
    values = c(16,15)
  ) +
  ggplot2::facet_wrap(~model,
                      scales = "free_x",
                      labeller = ggplot2::labeller(model = c(
                        `Model 2` = "Effect on √PSQI\n",
                        `Model 1` = "Effect on √BAI\n"
                      )))

# # Gráficos
#
# local({
#   cairo_pdf(file = "man/figures/figure-2.pdf", width = 8, height = 4);
#   print(fig);
#   dev.off()
# })
#
# local({
#   tiff(file = "man/figures/figure-2.tiff", width = 8, height = 4,
#        units = "in", res = 450);
#   print(fig);
#   dev.off()
# })
#
#

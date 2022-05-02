#' Power analysis for statistical test
#'
#' @noRd

test <- pwr::cohen.ES(test = "anov", size = "medium")

pwr::pwr.chisq.test(
  w = test$effect.size,
  N = nrow(anxiety),
  df = 2,
  sig.level = 0.05,
  #power = 0.8
)

pwr::pwr.t2n.test(
  n1 = nrow(anxiety[sex == "Female"]),
  n2 = nrow(anxiety[sex == "Male"]),
  d = c(0.3, 0.5),
  sig.level = 0.05,
  power = NULL,
)$power *


pwr::pwr.anova.test(
  k = 3,
  n = nrow(anxiety)/4,
  f = c(0.02, 0.13, 0.26),
  sig.level = 0.05
)


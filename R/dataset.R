#' Data from the anxiety and confinement study.
#'
#' @description
#' `r lifecycle::badge('stable')`
#'
#' This dataset contains the variables used in the anxiety and confinement study carried out
#' by Alvarado-Aravena et al. 2022.
#'
#'
#' @format A data frame with 617 rows y 7 variables:
#'
#' \itemize{
#'   \item{\code{id}: Factor. An identification code for each subject.}
#'   \item{\code{sex}: Factor w/ 2 levels "Female", "Male". Sex of participants.}
#'   \item{\code{zone}: Factor w/ 2 levels "CZ", "PZ". Zone in which the subject were by the time he was answering the questionnaire, either CZ (Confinement Zone) or PZ (Partial confinement Zone).}
#'   \item{\code{beck_global}: Integer. Global score of Beck Anxiety Inventory.}
#'   \item{\code{pits_global}: Integer. Global score of Pittsburgh Sleep Quality Index.}
#'   \item{\code{age}: Integer. Age of the subjects in years.}
#'   \item{\code{cat_age}: Factor w/ 4 levels "18-25", "26-40", "41-50", ">50". Age of the subjects in years.}
#' }
#'
#' @examples
#' # Mean age grouped by sex and zone using `data.table` syntax
#' anxiety[,  # No filtering (i)
#'         list(mean_age = mean(age)), # Action to do (j)
#'         list(sex, zone)] # Grouping vars (by)
#'
#' # Mean PSQI score grouped by sex and zone, for those with
#' # an age greater than 18 AND a Beck score greater than 10.
#' anxiety[age > 18 & beck_global > 10,
#'         list(mean_psqi = mean(pits_global)),
#'         list(sex, zone)]
#'
#' @source
#'  -  Alvarado-Aravena, C., Arriaza, K., Castillo-Aguilar, M., Flores, K.,
#'  Dagnino-Subiabre, A., Estrada-Goic, C., & Núñez-Espinosa, C. (2022). Effect
#'  of Confinement on Anxiety Symptoms and Sleep Quality during the COVID-19
#'  Pandemic. Behavioral Sciences, 12(10), 398.
"anxiety"





#' Homicides in the City of St. Louis, 2008 - 2018
#'
#' An example data set containing the addresses for homicides reported by the Saint Louis Metropolitan Police Department
#'
#' @docType data
#'
#' @usage data(stl_homicides)
#'
#' @format A tibble with 1822 rows and 6 variables:
#' \describe{
#'   \item{street_address}{number, street and street suffix where homicide occured}
#'   \item{year}{year homicide occurred}
#'   \item{date}{data homicide occurred}
#'   \item{state}{state abbreviation of location, in these data, all "MO"}
#'   \item{postal_code}{zipcode/postal code of location, in these data all NA}
#'   \item{city}{city of location, in these data all "St. Louis"}
#'   }
#'
#' @source \href{http://www.slmpd.org/Crimereports.shtml}{St. Louis Metropolitan Police Department}
#'
#' @examples
#' str(stl_homicides)
#' head(stl_homicides)
#'
"stl_homicides"

#' Homicides in the City of St. Louis July, 2018
#'
#' An example data set containing the addresses for homicides reported by the Saint Louis Metropolitan Police Department
#'
#' @docType data
#'
#' @usage data(stl_homicides_small)
#'
#' @format A tibble with 24 rows and 6 variables:
#' \describe{
#'   \item{street_address}{number, street and street suffix where homicide occured}
#'   \item{year}{year homicide occurred}
#'   \item{date}{data homicide occurred}
#'   \item{state}{state abbreviation of location, in these data, all "MO"}
#'   \item{postal_code}{zipcode/postal code of location, in these data all NA}
#'   \item{city}{city of location, in these data all "St. Louis"}
#'   }
#'
#' @source \href{http://www.slmpd.org/Crimereports.shtml}{St. Louis Metropolitan Police Department}
#'
#' @examples
#' str(stl_homicides_small)
#' head(stl_homicides_small)
#'
"stl_homicides_small"

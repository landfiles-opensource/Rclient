#' this function returns a data.frame with all farms in a given group
#' @param group a string id of the group, for intance "GR-96c6c34e-e884-483e-94af-6fabc055c4bd"
#' @param token a string with the token from getToken function
#' @return a data frame of all farms in the group
#' @import httr
#' @importFrom jsonlite fromJSON

getFarms <- function (group="",
                      token="") {
  result <- try(httr::GET(paste0("https://api.landfiles.fr/api/landfilesservice/v1/external/farms/groups/",group),
                         httr::content_type_json(),encode ="form",
                         httr::add_headers(Authorization = token)))
  if(result$status_code!=200)
  {
    stop(paste(httr::http_status(result)$message), call. = FALSE)
  } else
  {
    print(httr::http_status(result)$message)
  }
  DFfarms <- jsonlite::fromJSON(rawToChar(result$content))
  DFfarms <- DFfarms$farms
  return(DFfarms)
}

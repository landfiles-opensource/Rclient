#' this function returns a data.frame with all groups accessible with a given token
#'
#' @param token a string with the token from getToken function
#'
#' @return a data frame of all groups available with the token
#' @import httr
#' @importFrom jsonlite fromJSON
#' @export

getGroups <- function (token="") {
  result <- try(httr::GET(paste0("https://api.landfiles.fr/api/landfilesservice/v1/external/groups"),
                         httr::content_type_json(),encode ="form",
                         httr::add_headers(Authorization = token)))
  if(result$status_code!=200)
  {
    stop(paste(httr::http_status(result)$message), call. = FALSE)
  } else
  {
    print(httr::http_status(result)$message)
  }

  DFgroups <- jsonlite::fromJSON(rawToChar(result$content))
  return(DFgroups)
}

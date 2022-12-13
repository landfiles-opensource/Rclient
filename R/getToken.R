#' this function returns a token after authentication to landfiles API
#'
#' @param url is a string with the url of the API, by default https://api.landfiles.fr/api/authenticationservice/auth/oauth/token
#' @param username is a string
#' @param password is a string
#'
#' @return if the request is succesful the function returns a string token
#' @import httr
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest
#' @export


getToken <- function(url="https://api.landfiles.fr/api/authenticationservice/auth/oauth/token",
                              username="",
                              password="") {
  body <- list(
    username = username,
    password = password,
    scope = "mobileclient",
    grant_type = "password"
  )
  connect <- try(httr::POST(url,
                            query=body,
                            httr::add_headers(Authorization = "Basic bGFuZGZpbGVzOjVEazF6V2ZkYUllUG9tVkMxaFdTZk5NU0ZpbmtxRkFP"),
                            httr::content_type_json(),
                            encode = "form"))
  if(connect$status_code!=200)
  {
    stop(paste(httr::http_status(connect)$message), call. = FALSE)
  } else
  {
    print(httr::http_status(connect)$message)
  }
  token = paste(jsonlite::fromJSON(rawToChar(connect$content))$token_type, jsonlite::fromJSON(rawToChar(connect$content))$access_token)
  return(token)
}

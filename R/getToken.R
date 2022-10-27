# this function returns a token after authentication to landfiles API
#
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
  print(connect$status_code)
  token = paste(jsonlite::fromJSON(rawToChar(connect$content))$token_type, jsonlite::fromJSON(rawToChar(connect$content))$access_token)
  return(token)
}
# this fonction returns a data.frame with all farms in a group

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

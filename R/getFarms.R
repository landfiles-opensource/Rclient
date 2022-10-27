# this fonction returns a data.frame with all farms in a group

getFarms <- function (group="",
                      token="") {
  farms <- try(httr::GET(paste0("https://api.landfiles.fr/api/landfilesservice/v1/external/farms/groups/",group),
                         httr::content_type_json(),encode ="form",
                         httr::add_headers(Authorization = token)))
  DFfarms <- jsonlite::fromJSON(rawToChar(farms$content))
  DFfarms <- DFfarms$farms
  return(DFfarms)
}

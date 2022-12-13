#' this function returns a data.frame with all parcels in a group
#'
#' @param group a string id of the group, for intance "GR-96c6c34e-e884-483e-94af-6fabc055c4bd"
#' @param token a string with the token from getToken function
#'
#' @return a data frame of all groups available with the token
#' @import httr
#' @importFrom jsonlite fromJSON
#' @import magrittr
#' @importFrom dplyr mutate left_join
#' @importFrom tidyr pivot_wider
#' @export


getPlots <- function(group="",
                    token="") {
  parcelData <- dataType <- value <- valueLabel <- uuid <- dataLabel <- valueF <- NULL # to bound variable from result
  result <- try(httr::GET(paste0("https://api.landfiles.fr/api/landfilesservice/v1/external/parcels/groups/",group),
                             httr::content_type_json(),encode ="raw",
                             httr::add_headers(Authorization = token)))
  if(result$status_code!=200)
  {
    stop(paste(httr::http_status(result)$message), call. = FALSE)
  } else
  {
    print(httr::http_status(result)$message)
  }


  result_prcls = jsonlite::fromJSON(rawToChar(result$content))
  DFprcls<-result_prcls$parcels[[1]]
  DF <- unnest(DFprcls[c('uuid','parcelData')],cols = c(parcelData)) %>%
    dplyr::mutate(valueF = ifelse(dataType=="NUMBER",value,valueLabel)) %>%
    tidyr::pivot_wider(id_cols=uuid,names_from=dataLabel,values_from=valueF) %>%
    dplyr::left_join(DFprcls[1:6])
  return(DF)
}


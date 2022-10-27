# this fonction returns a data.frame with all parcels in a group

getPlot <- function(group="",
                    token="") {

  parcelles <- try(httr::GET(paste0("https://api.landfiles.fr/api/landfilesservice/v1/external/parcels/groups/",group),
                             httr::content_type_json(),encode ="raw",
                             httr::add_headers(Authorization = token)))

  result_prcls = jsonlite::fromJSON(rawToChar(parcelles$content))
  DFprcls<-result_prcls$parcels[[1]]
  library(tidyr)
  DF <- unnest(DFprcls[c('uuid','parcelData')],cols = c(parcelData)) %>%
    dplyr::mutate(valueF = ifelse(dataType=="NUMBER",value,valueLabel)) %>%
    pivot_wider(id_cols=uuid,names_from=dataLabel,values_from=valueF) %>%
    dplyr::left_join(DFprcls[1:6])
  return(DF)
}


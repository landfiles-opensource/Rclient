#' get observations in a group
#' get all observations between 2 dates made in a group
#' return a list with 2 elements : a data frame of observations and the name of cols
#' @import httr
#' @importFrom jsonlite fromJSON
#' @importFrom tidyr unnest

getObs <- function (group = "",
                    token = "",
                    startDate = "2022-01-01",
                    endDate = "2022-12-31") {
  result <- try(httr::GET(paste0("https://api.landfiles.fr/api/landfilesservice/v1/external/observations/groups/",group),
                       query=list(startDate= startDate,
                                  endDate = endDate),
                       httr::content_type_json(),encode ="form",
                       httr::add_headers(Authorization = token)))
  if(result$status_code!=200)
  {
    stop(paste(httr::http_status(result)$message), call. = FALSE)
  } else
  {
    print(httr::http_status(result)$message)
  }

  DFobs = jsonlite::fromJSON(rawToChar(result$content))
  obs <- tidyr::unnest(DFobs,cols = c(observations))
  obs <- tidyr::unnest(obs,cols=c(data))
  vecClass <- sapply(obs,class)
  labelCol <- colnames(obs)
  for (i in 1:ncol(obs))
  {
    if(vecClass[i]=="data.frame") {
      labelCol[i]<-na.exclude(unique(obs[[i]]$label))[1]
      obs[,i] <- ifelse(obs[[i]]$type=="LIST"|obs[[i]]$type=="MULTILIST",obs[[i]]$valueLabel,obs[[i]]$value)
    }
  }
  obs$date <- as.POSIXct(obs$date/1000, origin="1970-01-01")
  return(list(obs=obs,label=labelCol))
}

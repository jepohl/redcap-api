

redcap_export_dictionary <- function(token = NULL){
  
  if(is.null(token)){
    token <- readline(prompt = "Enter unique REDCap API token: ")
  }
  
  url <- "https://redcap.bumc.bu.edu/api/"
  formData <- list("token"=token,
                   content='metadata',
                   format='csv',
                   returnFormat='csv'
  )
  response <- httr::POST(url, body = formData, encode = "form")
  result <- httr::content(response)
  
  return(result)
}


get_instruments <- function(token=NULL){
  
  if(is.null(token)){token <- readline(prompt = "Enter unique REDCap API token: ")}
  
  url <- "https://redcap.bumc.bu.edu/api/"
  formData <- list("token"=token,
                   content='instrument',
                   format='csv',
                   returnFormat='csv'
  )
  response <- httr::POST(url, body = formData, encode = "form")
  result <- httr::content(response, show_col_types = FALSE, progress = FALSE)
  # print(result)
  return(result$instrument_name)
}


# instrument_names <- get_instruments(token)

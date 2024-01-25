
get_instruments <- function(url, token=NULL){
  
  if(is.null(token)){token <- readline(prompt = "Enter unique REDCap API token: ")}
  
  url <- url #"https://redcap.bumc.bu.edu/api/" or "https://redcap.partners.org/redcap/api/"
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

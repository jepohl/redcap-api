

redcap_export_instrument <- function(url, token = NULL, instrument = NULL, df_details = TRUE){
  
  if(is.null(token)){
    token <- readline(prompt = "Enter unique REDCap API token: ")
  }
  
  if(is.null(instrument)){
    instrument_names <- get_instruments(url, token)
    for(i in 1:length(instrument_names)){
      cat(i, instrument_names[i], "\n")}
    instrument <- instrument_names[as.numeric(readline(prompt = "Select the desired instrument number: "))]
  }
  
  
  url <- url #"https://redcap.bumc.bu.edu/api/" or "https://redcap.partners.org/redcap/api/"
  formData <- list("token"=token,
                   content='record',
                   action='export',
                   format='csv',
                   type='flat',
                   csvDelimiter=',',
                   'fields[0]'='id',
                   'forms[0]'=instrument,
                   rawOrLabel='raw',
                   rawOrLabelHeaders='raw',
                   exportCheckboxLabel='false',
                   exportSurveyFields='false',
                   exportDataAccessGroups='false',
                   returnFormat='csv'
  )

  
  response <- httr::POST(url, body = formData, encode = "form")
  redcap <- httr::content(response, encoding = 'UTF-8', 
                          guess_max = Inf, 
                          show_col_types = FALSE 
  )
  
  if(df_details){
    print(spec(redcap))
  }
  
  return(redcap)
}
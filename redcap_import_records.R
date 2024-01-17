
# df_to_csv <- function(df){
#   ## to do: write function that takes a dataframe and returns a string of comma seperated values
#   
#   return(csv)
# }



redcap_import_records <- function(data, token = NULL){
  
  if(is.null(token)){
    token <- readline(prompt = "Enter unique REDCap API token: ")
  }
  
  url <- "https://redcap.bumc.bu.edu/api/"
  formData <- list("token"=token,
                   content='record',
                   action='import',
                   format='csv',
                   type='flat',
                   overwriteBehavior='overwrite',
                   forceAutoNumber='false',
                   data=data,
                   dateFormat='YMD',
                   returnContent='count',
                   returnFormat='csv'
  )
  response <- httr::POST(url, body = formData, encode = "form")
  result <- httr::content(response)
  
  print(result)
}


# df_to_csv <- function(df){
#   ## to do: write function that takes a dataframe and returns a string of comma seperated values
#   
#   return(csv)
# }



redcap_import_records <- function(
  data, ## dataframe in redcap format to upload
  url, #"https://redcap.bumc.bu.edu/api/" or "https://redcap.partners.org/redcap/api/"
  token = NULL, ## REDCap API token
  overwrite = TRUE, ## Logical (T/F), should existing records be overwritten
  forceNewIDs = FALSE ## Force all data to be imported as a new patient(s)
  ){
  
  if(is.null(token)){token <- readline(prompt = "Enter unique REDCap API token: ")}
  if(overwrite){overwriteBehavior <-'overwrite'} else {overwriteBehavior <- 'normal'}
  if(forceNewIDs){forceAutoNumber <- 'true'} else {forceAutoNumber <- 'false'}
  
  formData <- list("token"=token,
                   content='record',
                   action='import',
                   format='csv',
                   type='flat',
                   overwriteBehavior=overwriteBehavior,
                   forceAutoNumber=forceAutoNumber,
                   data=data,
                   dateFormat='YMD',
                   returnContent='count',
                   returnFormat='csv'
  )
  response <- httr::POST(url, body = formData, encode = "form")
  result <- httr::content(response, show_col_types = FALSE, progress = FALSE)
  
  cat("Errors: \n")
  return(result)
}


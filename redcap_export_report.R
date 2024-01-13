redcap_export_report <- function(report_id, token = NULL, df_details = TRUE){
  
  if(is.null(token)){
    token <- readline(prompt = "Enter unique REDCap API token: ") #"3F21D4B6398BFFA9360681277CA2D7FF"
  }
  
  url <- "https://redcap.bumc.bu.edu/api/"
  formData <- list("token"=token,
                   content='report',
                   format='csv',
                   report_id=report_id, ## need to update depending on the report (34869)
                   csvDelimiter='',
                   rawOrLabel='raw',
                   rawOrLabelHeaders='raw',
                   exportCheckboxLabel='false',
                   returnFormat='csv'
  )
  
  response <- httr::POST(url, body = formData, encode = "form")
  redcap <- httr::content(response, encoding = 'UTF-8', 
                          guess_max = Inf, show_col_types = FALSE #,col_types = paste0(rep('c', 149), collapse = "")
  )
  
  if(df_details){
    print(dim(redcap))
    print(spec(redcap))
  }
  
  return(redcap)
}
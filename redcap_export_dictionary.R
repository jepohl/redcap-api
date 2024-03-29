

redcap_export_dictionary <- function(url, token = NULL){
  
  if(is.null(token)){
    token <- readline(prompt = "Enter unique REDCap API token: ")
  }
  
  url <- url #"https://redcap.bumc.bu.edu/api/" or "https://redcap.partners.org/redcap/api/"
  formData <- list("token"=token,
                   content='metadata',
                   format='csv',
                   returnFormat='csv'
  )
  response <- httr::POST(url, body = formData, encode = "form")
  result <- httr::content(response, show_col_types = FALSE, progress = FALSE)
  
  return(result)
}


# token <- "3F21D4B6398BFFA9360681277CA2D7FF"
# data_dict <- redcap_export_dictionary(token)
# id_field <- data_dict$field_name[1]
# instrument_fields <- data_dict[which(data_dict$form_name=='vital_sign_data' & data_dict$field_type!='calc'),][['field_name']]
# cacl_fields <- data_dict[which(data_dict$form_name=='vital_sign_data' & data_dict$field_type=='calc'),][['field_name']]

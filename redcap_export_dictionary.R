

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
  result <- httr::content(response, show_col_types = FALSE, progress = FALSE)
  
  return(result)
}



# data_dict <- redcap_export_dictionary(token)
# id_field <- data_dict$field_name[1]
# instrument_fields <- data_dict[which(data_dict$form_name=='vital_sign_data' & data_dict$field_type!='calc'),][['field_name']]
# cacl_fields <- data_dict[which(data_dict$form_name=='vital_sign_data' & data_dict$field_type=='calc'),][['field_name']]

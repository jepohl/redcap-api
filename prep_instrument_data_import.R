# rm(list = setdiff(ls(), lsf.str()))


prep_instrument_data_import <- function(data, url, token = NULL, instrument = NULL, autoNumberInstances = FALSE){
  require(tidyverse)
  
  url <- url #"https://redcap.bumc.bu.edu/api/" or "https://redcap.partners.org/redcap/api/"
  
  if(is.null(token)){token <- readline(prompt = "Enter unique REDCap API token: ")}
  instrument_names <- get_instruments(url, token)
  
  if(is.null(instrument)){
    for(i in 1:length(instrument_names)){cat(i, instrument_names[i], "\n")}
    instrument <- instrument_names[as.numeric(readline(prompt = "Select the desired instrument number: "))]
  } else if(!(instrument %in% instrument_names)){
    cat("INVALID INSTRUMENT NAME...\n")
    for(i in 1:length(instrument_names)){cat(i, instrument_names[i], "\n")}
    instrument <- instrument_names[as.numeric(readline(prompt = "Select the desired instrument number: "))]
  }
  
  data_dict <- redcap_export_dictionary(url, token)
  data_dict <- data_dict[which(data_dict$form_name==instrument),]
  instrument_fields <- c("id", data_dict$field_name)
  calculated_fields <- data_dict$field_name[which(data_dict$field_type == "calc")]
  
  cat("Selecting relevant field names: ", colnames(data)[which(colnames(data) %in% instrument_fields)], "\n")
  cat("Removing irrelevant filed names: ", colnames(data)[which(!colnames(data) %in% instrument_fields)], "\n")
  data <- data[,which(colnames(data) %in% instrument_fields)]
  
  if(length(calculated_fields) > 0){
    cat("Removing calculated REDCap fields: ", calculated_fields, "\n")
    data <- data[,which(!colnames(data) %in% calculated_fields)] 
  }
  
  cat("Adding column for instrument: ", instrument, "\n")
  data <- mutate(data, redcap_repeat_instrument = instrument, .after = 'id')
  
  if(autoNumberInstances){
    cat("Automatically numbering repeat instances...", "\n")
    data <- mutate(data, redcap_repeat_instance = "new", .after = 'redcap_repeat_instance')
  } else {
    cat("Adding repeat instances numbers...", "\n")
    data <- group_by(data, id)
    data <- mutate(data, redcap_repeat_instance = row_number(), .after = 'redcap_repeat_instance')
    data <- ungroup(data)
  }
  
  cat("Adding the completeness indicator column...\n")
  data <- mutate(data, !!paste0(instrument, '_complete') := '2')
    
  cat("Converting to CSV object...", "\n")
  data <- readr::format_csv(data, na = "", quote = "needed")
  
  return(data)
  
}


# token <- "3F21D4B6398BFFA9360681277CA2D7FF"
# df <- data.frame(id = c(rep(100,3), rep(101,3), rep(102,3)),
#                    vitaldt = lubridate::now() + lubridate::minutes(sample(1:100, 9)),
#                    sbp = rnorm(9, 95, 5),
#                    banana = rnorm(9))
# 
# 
# df_str <- prep_instrument_data_import(df, token, instrument = 'vital_sign_data')


library(tsdo)
library(tsda)
library(readxl)



read_excelSheet_rtm <-function(excel_file) {

  #library(readxl)
  res<- read_excel(excel_file)
  res <- as.data.frame(res);
  res$FSourceFile <- excel_file
  return(res);

}
read_rtm<-function(dir_files) {
  files <- dir(dir_files)
  files <-paste(dir_files,files,sep="/");
  #get files
  res <-lapply(files, read_excelSheet_rtm)
  #get names
  field_names <-lapply(res,names)
  #sheet name
  sheet_header <- field_names[[1]];
  res <- do.call("rbind",res);
  names(res) <- sheet_header;
  return(res);
}

mydata <- read_rtm("data-raw/rtm_qty")

View(mydata)


openxlsx::write.xlsx(mydata,'rtm_qty.xlsx')

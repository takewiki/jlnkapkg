# 1.下载的文件格式xls有问题，需要另存为xlsx-------

#' 读取walmart数据源
#'
#' @param file 文件名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_readSrc_walmart()
nka_readSrc_walmart <- function(file="data-raw/walmart_202011_downloads/xlsx/walmart_202011_01.xlsx",
                                FUser='RDS') {

  data <- readxl::read_excel(file,
                                  col_types = c("text", "text", "text",
                                                "text", "text", "text", "text", "text",
                                                "text", "numeric", "numeric"), skip = 21)
  names(data) <- c("Daily","Fineline","ItemNbr",  "ItemFlags" ,
  "ItemDesc1",         "VendorNbr"  ,        "VendorNbrDept"  ,   "VendorSequenceNbr",
  "StoreNbr" ,          "POSQty"   ,          "POSSales"    ,   "FExcelWorkBookName" ,
  "FExcelWorkSheetName", "FExcelRowNo"   ,      "FUser"     ,          "FWriteDate")
  #进行格式规范化处理
  data$Daily <- as.character(as.Date(data$Daily))

  data$FExcelWorkBookName <- file
  data$FExcelWorkSheetName <-readxl::excel_sheets(file)[1]
  data$FExcelRowNo <- 1:nrow(data)
  data$FUser <- FUser
  data$FWriteDate <-as.character(Sys.Date())
  return(data)
}


#' 写入数据源
#'
#' @param file 文件
#' @param FUser 用户
#' @param conn 连接
#' @param table_name 表名
#'
#' @return 写入结果
#' @export
#'
#' @examples
#' nka_writeSrc_walmart()
nka_writeSrc_walmart <- function(file="data-raw/walmart_202011_downloads/xlsx/walmart_202011_01.xlsx",
                                 FUser='RDS',
                                 conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                                 table_name='t_nka_src_walmart'){
  data <- nka_readSrc_walmart(file = file,FUser = FUser)
  View(data)
  try({
    sqlr::sql_writeTable(conn =conn,table_name = table_name,r_object = data,append = T )
  })

}

#' 批量写入walmart数据源
#'
#' @param dir 路径
#' @param FUser 用户
#' @param conn 连接
#' @param table_name 表名
#'
#' @return 无返回值
#' @export
#'
#' @examples
#' nka_writeSrcBatch_walmart()
nka_writeSrcBatch_walmart <- function(dir="data-raw/walmart_202011_downloads/xlsx",
                                 FUser='RDS',
                                 conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                                 table_name='t_nka_src_walmart'){
  #获取目录下所有文件
  files <-dir(dir,full.names = T)
  lapply(files, function(file){
    nka_writeSrc_walmart(file=file,FUser = FUser,conn = conn,table_name = table_name)
    #print(file)
  })


}







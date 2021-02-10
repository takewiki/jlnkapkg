
#' 读取家乐福数据
#'
#' @param file 文件名
#' @param file_short  短文件名
#' @param FUser 用户
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_readSrc_carrefour()
nka_readSrc_carrefour<- function(file="data-raw/jlnka_202011/carrefour_202011_downloads/carrefour_202011.xlsx",
                          file_short ='carrefour_202011.xlsx',
                          FUser='RDS'){
  data <- readxl::read_excel("data-raw/jlnka_202011/carrefour_202011_downloads/carrefour_202011.xlsx",
                             col_types = c("text", "text", "text",
                                           "text", "text", "text", "text", "text",
                                           "text", "text", "text", "text", "text",
                                           "numeric", "numeric"))
  names(data) <- c(
    'FSettleDate',
    'FDistrictCode',
    'FDistrictName',
    'FShopCode',
    'FShopName',
    'F8SKU_Code',
    'F8SKU_Name',
    'FItemNO',
    'FItemName',
    'FSupplierCode',
    'FSupplierName',
    'FSupplierCode2',
    'FSupplierName2',
    'FSaleQty',
    'FSaleAmt'
  )
  data$FExcelWorkBookName <- file
  data$FExcelWorkSheetName <- file_short
  data$FExcelRowNo <- 1:nrow(data)
  data$FUser <- FUser
  data$FWriteDate <- as.character(Sys.Date())
  return(data)


}




#' 写入carrefour数据
#'
#' @param file  文件名
#' @param file_short 短文件名
#' @param FUser 用户
#' @param conn 连接
#' @param table_name 表名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_writeSrc_carrefour()
nka_writeSrc_carrefour <- function(file="data-raw/jlnka_202011/carrefour_202011_downloads/carrefour_202011.xlsx",
                                   file_short ='carrefour_202011.xlsx',
                                   FUser='RDS',
                                 conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                                 table_name='t_nka_src_carrefour'){
  data <- nka_readSrc_carrefour(file = file,file_short = file_short,FUser = FUser)
  try({
    sqlr::sql_writeTable(conn =conn,table_name = table_name,r_object = data,append = T )
  })



}



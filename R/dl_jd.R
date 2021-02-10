# 新通路业务数据

#读取新通路数据

#' 读取新通路的标准化后的日期
#'
#' @param dir_name 目录
#'
#' @return 返回日期字段
#' @export
#'
#' @examples
#' kna_getDate_jd()
kna_getDate_jd <- function(dir_name = "data-raw/jlnka_202011/jd_202011_downloads") {

  files <- dir(dir_name)

  files_split <-strsplit(files,"_")
  ncount <- length(files_split)
  res <- character(ncount)
  lapply(1:ncount, function(i){
    #处理规则
    date1 <- files_split[[i]][2]
    date2 <- strsplit( date1,"\\.")[[1]][1]
    res[i] <<- as.character(as.Date(date2,format= '%Y%m%d'))
  })
  return(res)


}


#' 新通路读取数据源
#'
#' @param file 文件
#' @param file_short 短文件
#' @param FSaleDate 销售日期
#' @param FUser 用户
#'
#' @return 返回表
#' @export
#'
#' @examples
#' nka_readSrc_jd()
nka_readSrc_jd<- function(file="data-raw/jlnka_202011/jd_202011_downloads/JD_20201101.xlsx",
                               file_short ='JD_20201101.xlsx',
                                FSaleDate ="2020-11-01",
                               FUser='RDS'){
  data <- readxl::read_excel(file,
                            col_types = c("text", "text", "text",
                                          "text", "text", "text", "numeric",
                                          "numeric", "numeric", "numeric"))
  names(data) <- c(
    'FItemName',
    'FItemNo',
    'FSaleProvince',
    'FSaleCity',
    'FSaleDistrict',
    'FSaleAmt',
    'FShopCount',
    'FOrderQty',
    'FSalePieceQty',
    'FOrderPieceQty'
  )
  #针对千分位的金额进行处理
  data$FSaleAmt <-as.numeric(stringr::str_remove(data$FSaleAmt,","))
  data$FSaleDate <- FSaleDate
  data$FExcelWorkBookName <- file
  data$FExcelWorkSheetName <- file_short
  data$FExcelRowNo <- 1:nrow(data)
  data$FUser <- FUser
  data$FWriteDate <- as.character(Sys.Date())
  return(data)

}


#' 写入京东数据
#'
#' @param file 文件
#' @param file_short 短文件
#' @param FSaleDate 销售日期
#' @param FUser 用户
#' @param conn 连接
#' @param table_name 表名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_writeSrc_jd()
nka_writeSrc_jd <- function(file="data-raw/jlnka_202011/jd_202011_downloads/JD_20201101.xlsx",
                            file_short ='JD_20201101.xlsx',
                            FSaleDate ="2020-11-01",
                            FUser='RDS',
                            conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                            table_name='t_nka_src_jd'
                            ){
  data <- nka_readSrc_jd(file = file,file_short = file_short,FSaleDate = FSaleDate,FUser = FUser)
  try({
    sqlr::sql_writeTable(conn =conn,table_name = table_name,r_object = data,append = T )
  })


}


#' 批量写入京东数据
#'
#' @param dir_name 目录
#' @param FUser 用户
#' @param conn 连接
#' @param table_name 表名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_writeSrcBatch_jd()
nka_writeSrcBatch_jd <- function(dir_name="data-raw/jlnka_202011/jd_202011_downloads",
                            FUser='RDS',
                            conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                            table_name='t_nka_src_jd'
){
  files <- dir(dir_name,full.names = T)
  files_short <-dir(dir_name,full.names = F)
  FSaleDates <- kna_getDate_jd(dir_name = dir_name)
  ncount <- length(files)
  lapply(1:ncount, function(i){
    file = files[i]
    print(file)
    file_short = files_short[i]
    FSaleDate <- FSaleDates[i]
    nka_writeSrc_jd(file=file,file_short = file_short,FSaleDate = FSaleDate,FUser = FUser,conn = conn,table_name = table_name)
  })


}










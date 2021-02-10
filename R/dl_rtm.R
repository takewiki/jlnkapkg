# 日报金额处理----------

#' 获取用户账号
#'
#' @param dir_name 目录名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' kna_rtm_getUserId()
nka_getUserId_rtm <- function(dir_name="data-raw/jlnka_202011/rtm_202011_downloads/Daily") {

  mystr <- dir(dir_name,full.names = F)

  mysplit <-strsplit(mystr,"_")
  ncount <- length(mysplit)
  res <- character(ncount)
  lapply(1:ncount, function(i){
    res[i] <<- mysplit[[i]][2]
  })

  return(res)
}


#' 计取日报数据
#'
#' @param file 文件
#' @param FLoginAcct 登录账号
#' @param file_short 短文件
#' @param FUser 用户
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_readSrc_rtm_daily()
nka_readSrc_rtm_daily <- function(file="data-raw/jlnka_202011/rtm_202011_downloads/Daily/RTM_rt210602_2020-11-01.xlsx",
                            file_short="RTM_rt210602_2020-11-01.xlsx",
                            FLoginAcct='rt210602',
                            FUser='RDS'

                            ) {
  data <- readxl::read_excel(file,
                             col_types = c("text", "numeric", "text",
                                           "text"))
  data <- data[!is.na(data$`店 号`),]
  data <- data[data$`店 号` != '合 计',]
  names(data) <- c('FShopNo',
                   'FSaleAmt',
                   'FRTMDistrict',
                   'FSaleDate')
  data$FSaleDate <- as.Date(data$FSaleDate)
  data$FLoginAcct <- FLoginAcct
  data$FExcelWorkBookName <-file
  data$FExcelWorkSheetName <- file_short
  data$FExcelRowNo <- 1:nrow(data)
  data$FUser <- FUser
  data$FWriteDate <-as.character(Sys.Date())
  return(data)



}

#' 写入大润发日数据
#'
#' @param file 文件名
#' @param file_short 短文件名
#' @param FLoginAcct walmart账号
#' @param FUser  写入中间表用户
#' @param conn 连接
#' @param table_name  表名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_writeSrc_rtm_daily()
nka_writeSrc_rtm_daily <- function(file="data-raw/jlnka_202011/rtm_202011_downloads/Daily/RTM_rt210602_2020-11-01.xlsx",
                                   file_short="RTM_rt210602_2020-11-01.xlsx",
                                   FLoginAcct='rt210602',
                                 FUser='RDS',
                                 conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                                 table_name='t_nka_src_rtm_day'){
  data <- nka_readSrc_rtm_daily(file=file,file_short = file_short,FLoginAcct=FLoginAcct,FUser=FUser)
  # print(head(data))
  try({
    sqlr::sql_writeTable(conn =conn,table_name = table_name,r_object = data,append = T )
  })

}


#' 批量写入日报数据
#'
#' @param dir_name 目录
#' @param FUser 写入中间表用户
#' @param conn 连接
#' @param table_name 表名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_writeSrcBatch_rtm_daily()
nka_writeSrcBatch_rtm_daily <- function(dir_name="data-raw/jlnka_202011/rtm_202011_downloads/Daily",

                                   FUser='RDS',
                                   conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                                   table_name='t_nka_src_rtm_day'){
  files <- dir(dir_name,full.names = T)
  files_short <-dir(dir_name,full.names = F)
  FLoginAccts <- nka_getUserId_rtm(dir_name)
  ncount <- length(files)
  lapply(1:ncount, function(i){
    file = files[i]
    print(file)
    file_short = files_short[i]
    FLoginAcct = FLoginAccts[i]
    nka_writeSrc_rtm_daily(file = file,file_short = file_short ,FLoginAcct = FLoginAcct,FUser = FUser,conn = conn,table_name = table_name)
  })

}





#备注：目前两天的数据--------
# 数据重新导入









# 月报数量处理----------

#' 月报批量写入中间表
#'
#' @param file 文件
#' @param file_short  短文件
#' @param FLoginAcct 登录名
#' @param FUser 用户
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_readSrc_rtm_monthly()
nka_readSrc_rtm_monthly <- function(file="data-raw/jlnka_202011/rtm_202011_downloads/Month/RTM_rt211571_2020-11.xlsx",
                                    file_short='RTM_rt211571_2020-11.xlsx',
                                    FLoginAcct='rt211571',
                                    FUser='RDS'
                                    ){
  #计取数据
  data <- readxl::read_excel(file,
                             col_types = c("numeric", "numeric", "text","text", "numeric"),
                             skip = 2)
  names(data) <- c('FSaleYear','FSaleMonth','FShopNo','FItemNo','FSaleQty')
  data$FSaleYear <- as.integer(data$FSaleYear)
  data$FSaleMonth <- as.integer(data$FSaleMonth)
  data$FLoginAcct <-FLoginAcct
  data$FExcelWorkBookName <- file
  data$FExcelWorkSheetName <- file_short
  data$FExcelRowNo <- 1:nrow(data)
  data$FUser <-FUser
  data$FWriteDate <- as.character(Sys.Date())
  return(data)



}




#' 写入月报数据
#'
#' @param file 文件
#' @param file_short 短文件名
#' @param FLoginAcct walmart登录名
#' @param FUser 用户
#' @param conn 连接
#' @param table_name 表名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_writeSrc_rtm_monthly()
nka_writeSrc_rtm_monthly <- function(file="data-raw/jlnka_202011/rtm_202011_downloads/Month/RTM_rt211571_2020-11.xlsx",
                                     file_short='RTM_rt211571_2020-11.xlsx',
                                     FLoginAcct='rt211571',
                                     FUser='RDS',
                                   conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                                   table_name='t_nka_src_rtm_month'){
  data <- nka_readSrc_rtm_monthly(file=file,file_short = file_short,FLoginAcct = FLoginAcct,FUser = FUser)
   print(head(data))
  try({
    sqlr::sql_writeTable(conn =conn,table_name = table_name,r_object = data,append = T )
  })

}

#' 批量写入月报数据
#'
#' @param dir_name 目标
#' @param FUser 用户
#' @param conn 连接
#' @param table_name  表名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_writeSrcBatch_rtm_monthly()
nka_writeSrcBatch_rtm_monthly <- function(dir_name="data-raw/jlnka_202011/rtm_202011_downloads/Month",

                                        FUser='RDS',
                                        conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                                        table_name='t_nka_src_rtm_month'){
  files <- dir(dir_name,full.names = T)
  files_short <-dir(dir_name,full.names = F)
  FLoginAccts <- nka_getUserId_rtm(dir_name)
  ncount <- length(files)
  lapply(1:ncount, function(i){
    file = files[i]
    print(file)
    file_short = files_short[i]
    FLoginAcct = FLoginAccts[i]
    nka_writeSrc_rtm_monthly(file = file,file_short = file_short ,FLoginAcct = FLoginAcct,FUser = FUser,conn = conn,table_name = table_name)
  })

}










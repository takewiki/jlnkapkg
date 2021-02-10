#发票创建日期与销售日期同月不调整，跨月的销售日期取发票期间第一天；
# 发票创建日期就是报表列新周期；
# 发票创建日期需要进行拆分

#' 将文件名中的代码转化为类别
#'
#' @param x 代码
#'
#' @return 返回代码对应的名称
#' @export
#'
#' @examples
#' getCategoryName()
getCategoryName <- function(x) {
  if(x == 'NS'){
    res <- '男士'
  }else if(x == 'MM'){
    res <- '面膜'
  }else if (x =='CX'){
    res <-'春夏'
  }else{
    res <- '未知'
  }

}

#' 获取watson的类型
#'
#' @param dir_name 目录
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_getCategory_watsons()
nka_getCategory_watsons <- function(dir_name="data-raw/jlnka_202011/Watsons_202011_downloads/xlsx") {

  mystr <- dir(dir_name,full.names = F)

  mysplit <-strsplit(mystr,"_")
  ncount <- length(mysplit)
  res <- character(ncount)
  lapply(1:ncount, function(i){
    res[i] <<- getCategoryName(mysplit[[i]][1])
  })

  return(res)
}





#' 读取数据
#'
#' @param file 文件名
#' @param file_short 短文件名
#' @param FCategory 分类
#' @param FUser 用户
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_readSrc_watsons()
nka_readSrc_watsons<- function(file="data-raw/jlnka_202011/Watsons_202011_downloads/xlsx/CX_20201102.xlsx",
                               file_short ='CX_20201102.xlsx',
                               FCategory='春夏',
                               FUser='RDS'
                               ) {



  data <- readxl::read_excel(file,
                            col_types = c("text", "text", "text",
                                          "text", "text", "text", "text", "text",
                                          "date", "numeric", "numeric", "numeric",
                                          "numeric", "numeric", "numeric"))
  names(data) <- c('FInvoiceCreateDateRange',
                   'FSupplierNO',
                   'FSupplierName',
                   'FInvoiceNo',
                   'FShopNo',
                   'FJV',
                   'FItemNo',
                   'FItemDesc',
                   'FSaleDate',
                   'Fqty',
                   'FNetSaleAmt',
                   'FSaleAmt',
                   'FSaleRatio',
                   'FExcludeAmt',
                   'FIncludeAmt')
  data$Fcategory <- FCategory
  data$FExcelWorkBookName <- file
  data$FExcelWorkSheetName <- file_short
  data$FExcelRowNo <- 1:nrow(data)
  data$FUser <- FUser
  data$FWriteDate <-as.character(Sys.Date())
  return(data)

}


#' 写入watson的数据源
#'
#' @param file 文件名
#' @param file_short 短文件名
#' @param FCategory 类别
#' @param FUser 用户
#' @param conn 连接
#' @param table_name  表名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_writeSrc_watsons()
nka_writeSrc_watsons <- function(file="data-raw/jlnka_202011/Watsons_202011_downloads/xlsx/CX_20201102.xlsx",
                                 file_short ='CX_20201102.xlsx',
                                 FCategory='春夏',
                                 FUser='RDS',
                                 conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                                 table_name='t_nka_src_watsons'){
  data <- nka_readSrc_watsons(file = file,file_short = file_short,FCategory = FCategory ,FUser = FUser)
  try({
    sqlr::sql_writeTable(conn =conn,table_name = table_name,r_object = data,append = T )
  })

}


#' 批量写入数据
#'
#' @param dir_name 目录名称
#' @param FUser 用户
#' @param conn 连接名
#' @param table_name 表名
#'
#' @return 返回值
#' @export
#'
#' @examples
#' nka_writeSrcBatch_watsons()
nka_writeSrcBatch_watsons <- function(dir_name="data-raw/jlnka_202011/Watsons_202011_downloads/xlsx",
                                 FUser='RDS',
                                 conn=sqlr::sql_conn_common(db_name = 'jlnka'),
                                 table_name='t_nka_src_watsons'){
  files <- dir(dir_name,full.names = T)
  files_short <-dir(dir_name,full.names = F)
  FCateogrys <- nka_getCategory_watsons(dir_name = dir_name)
  ncount <- length(files)
  lapply(1:ncount, function(i){
    file = files[i]
    print(file)
    file_short = files_short[i]
    FCategory <- FCateogrys[i]
    nka_writeSrc_watsons(file = file,file_short = file_short,FCategory = FCategory,FUser = FUser,conn = conn,table_name = table_name)
  })

}



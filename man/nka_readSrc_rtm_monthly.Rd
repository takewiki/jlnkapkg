% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dl_rtm.R
\name{nka_readSrc_rtm_monthly}
\alias{nka_readSrc_rtm_monthly}
\title{月报批量写入中间表}
\usage{
nka_readSrc_rtm_monthly(
  file = "data-raw/jlnka_202011/rtm_202011_downloads/Month/RTM_rt211571_2020-11.xlsx",
  file_short = "RTM_rt211571_2020-11.xlsx",
  FLoginAcct = "rt211571",
  FUser = "RDS"
)
}
\arguments{
\item{file}{文件}

\item{file_short}{短文件}

\item{FLoginAcct}{登录名}

\item{FUser}{用户}
}
\value{
返回值
}
\description{
月报批量写入中间表
}
\examples{
nka_readSrc_rtm_monthly()
}

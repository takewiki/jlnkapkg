library(jlnkapkg)

# nka_readSrc_jd("data-raw/jlnka_202011/jd_202011_downloads/JD_20201111.xlsx") ->mydata
# View(mydata)
#
#
# nka_writeSrc_jd("data-raw/jlnka_202011/jd_202011_downloads/JD_20201111.xlsx")
# 202011月数据处理
# nka_writeSrcBatch_jd()

# 202010

# dir_name <- "data-raw/jlnka_202010/jd_202010_downloads"
# nka_writeSrcBatch_jd(dir_name = dir_name)



# 202012


dir_name <- "data-raw/jlnka_202012/jd_202012_downloads"
nka_writeSrcBatch_jd(dir_name = dir_name)

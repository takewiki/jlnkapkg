USE [jlnka]
GO

/****** Object:  Table [dbo].[t_nka_src_rtm_month]    Script Date: 2021-02-08 11:02:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

drop table t_nka_src_rtm_month
go

CREATE TABLE [dbo].[t_nka_src_rtm_month](
	[FSaleYear] [int] NULL,
	[FSaleMonth] [int] NULL,
	[FShopNo] [nvarchar](255) NULL,
	[FItemNo] [nvarchar](255) NULL,
	[FSaleQty] [float] NULL,
	[FLoginAcct] [nvarchar](255) NULL,
	[FExcelWorkBookName] [nvarchar](255) NULL,
	[FExcelWorkSheetName] [nvarchar](255) NULL,
	[FExcelRowNo] [int]  NOT NULL,
	FUser varchar(30),
	FWriteDate varchar(30)
) ON [PRIMARY]
GO


FSaleYear FSaleMonth FShopNo  FItemNo FSaleQty FLoginAcct FExcelWorkBookName     FExcelWorkSheetN… FExcelRowNo FUser FWriteDate


select * from t_nka_src_rtm_month

sp_help t_nka_src_rtm_month

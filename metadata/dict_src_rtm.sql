USE [jlnka]
GO

/****** Object:  Table [dbo].[t_nka_src_rtm_day]    Script Date: 2021-02-08 9:50:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--drop table t_nka_src_rtm_day

CREATE TABLE [dbo].[t_nka_src_rtm_day](
	[FShopNo] [nvarchar](255) NULL,
	[FSaleAmt] [float] NULL,
	[FRTMDistrict] [nvarchar](255) NULL,
	[FSaleDate] [date] NULL,
	[FLoginAcct] [nvarchar](255) NULL,
	[FExcelWorkBookName] [nvarchar](255) NULL,
	[FExcelWorkSheetName] [nvarchar](255) NULL,
	[FExcelRowNo] [int]  NOT NULL,
	FUser varchar(30),
	FWriteDate varchar(30)
) ON [PRIMARY]
GO

select * from t_nka_src_rtm_day


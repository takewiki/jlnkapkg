USE [jlnka]
GO

/****** Object:  Table [dbo].[t_nka_src_watsons]    Script Date: 2021-02-08 14:19:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

drop table t_nka_src_watsons
go

CREATE TABLE [dbo].[t_nka_src_watsons](
	[FInvoiceCreateDateRange] [nvarchar](255) NULL,
	[FSupplierNO] [nvarchar](255) NULL,
	[FSupplierName] [nvarchar](255) NULL,
	[FInvoiceNo] [nvarchar](255) NULL,
	[FShopNo] [nvarchar](255) NULL,
	[FJV] [nvarchar](255) NULL,
	[FItemNo] [nvarchar](255) NULL,
	[FItemDesc] [nvarchar](255) NULL,
	[FSaleDate] [date] NULL,
	[Fqty] [float] NULL,
	[FNetSaleAmt] [float] NULL,
	[FSaleAmt] [float] NULL,
	[FSaleRatio] [float] NULL,
	[FExcludeAmt] [float] NULL,
	[FIncludeAmt] [float] NULL,
	[Fcategory] [nvarchar](255) NULL,
	[FExcelWorkBookName] [nvarchar](255) NULL,
	[FExcelWorkSheetName] [nvarchar](255) NULL,
	[FExcelRowNo] [int]  NOT NULL,
	FUser varchar(30),
	FWriteDate varchar(30)
) ON [PRIMARY]
GO

select   count(1)  from t_nka_src_watsons

use jlnka
go

select * from t_nka_src_jd


Drop table t_nka_src_jd
go
CREATE TABLE [dbo].[t_nka_src_jd](
	[FItemName] [nvarchar](255) NULL,
	[FItemNo] [nvarchar](255) NULL,
	[FSaleProvince] [nvarchar](255) NULL,
	[FSaleCity] [nvarchar](255) NULL,
	[FSaleDistrict] [nvarchar](255) NULL,
	[FSaleAmt] [float] NULL,
	[FShopCount] [float] NULL,
	[FOrderQty] [float] NULL,
	[FSalePieceQty] [float] NULL,
	[FOrderPieceQty] [float] NULL,
	[FSaleDate] [date] NULL,
	[FExcelWorkBookName] [nvarchar](255) NULL,
	[FExcelWorkSheetName] [nvarchar](255) NULL,
	[FExcelRowNo] [int]  NOT NULL,
	FUser varchar(30),
	FWriteDate varchar(30)
) ON [PRIMARY]
GO


---sp_help t_nka_src_jd

select * from t_nka_src_jd
where FSaleDate='2020-12-31'

create  TABLE [dbo].[t_nka_src_walmart](
	[Daily] [nvarchar](255) NULL,
	[Fineline] [nvarchar](255) NULL,
	[ItemNbr] [nvarchar](255) NULL,
	[ItemFlags] [nvarchar](255) NULL,
	[ItemDesc1] [nvarchar](255) NULL,
	[VendorNbr] [nvarchar](255) NULL,
	[VendorNbrDept] [nvarchar](255) NULL,
	[VendorSequenceNbr] [nvarchar](255) NULL,
	[StoreNbr] [nvarchar](255) NULL,
	[POSQty] [float] NULL,
	[POSSales] [float] NULL,
	[FExcelWorkBookName] [nvarchar](255) NULL,
	[FExcelWorkSheetName] [nvarchar](255) NULL,
	[FExcelRowNo] [int]  NOT NULL,
	FUser varchar(30)  null,
	FWriteDate varchar(30)

) ON [PRIMARY]
GO



select distinct FExcelWorkBookName,FExcelWorkSheetName from t_nka_src_walmart


select sum(POSSales) from t_nka_src_walmart

select   top 100 POSSales from t_nka_src_walmart


--数据源
select top 10  * from   t_nka_src_watsons

--查看完整记账的行数
select count(1) from   t_nka_src_watsons
where Fcategory ='春夏'


--删除空白行

delete  from   t_nka_src_watsons
where Fcategory  is null


--查看数据结构
select top 1 *  from   t_nka_src_watsons
where Fcategory ='春夏'


----insert into t_nka_src_watsons
----select * from 春夏$

---drop table 春夏$



---处理春夏数据
insert into t_nka_fact
select distinct  * from t_nka_ods_watsons
where FBrandName ='春夏'




insert into  t_nka_fact4hana
SELECT   a.[FSaleChannel]
      ,a.[FSaleYear]
      ,a.[FSaleMonth]
      ,a.[FSaleWeekNo]
      ,CONVERT(varchar(10), cast(a.FSaleDate as datetime), 120)  as FSaleDate
      ,a.[FShopNo]
      ,a.[FCustManager]
      ,a.[FKADistrictManager]
      ,a.[FDistrictManager]
      ,a.[FAreaRetailManager]
      ,a.[FDistrictAssistant]
      ,a.[FShopName]
      ,a.[FSaleDivision]
      ,a.[FSaleProvince]
      ,a.[FSaleCity]
      , b.FCXSupplierCode   as [FSupplierCode]
      ,a.[FSupplierName]
      ,a.[FSupplierShortName]
      ,a.[FProductNo]
      , c.FItemNo   as [FSAPItemNo]
      ,a.[FProductName]
      ,a.[FQRCode]
      ,a.[FBrandName]
      ,a.[FItemCategory]
      ,a.[FItemSeries]
      ,a.[FSubCategory]
      ,a.[FStandardRetailPrice]
      ,a.[FSaleQty]
      ,a.[FExcludeTaxSaleAmt]
      ,a.[FIncludeTaxSaleAmt]
      ,a.[FOriginalRetailAmt]
      ,a.[FInvoiceCreateDateRange]
      ,a.[FSalePackStyle]
  FROM [dbo].[t_nka_fact4hana_bak203] a
  left join t_nka_watsons_shopList b
on a.FSupplierName = b.FCXSupplierName
left join t_nka_item c
on  a.FProductName = c.FItemName
where a.FSaleChannel ='屈臣氏' and a.FBrandName ='春夏'



---定义数据处理视图
create view t_nka_ods_watsons as
select   '屈臣氏' as FSaleChannel,
year(FSaleDate) as FSaleYear,
month(FSaleDate) as FSaleMonth,
datepart(wk,FSaleDate) as FSaleWeekNo,
FSaleDate,
f.FShopNo ,
s.FCustManager,

'' as FKADistrictManager,
s.FDistrictManager,
s.FPOSManager as FAreaRetailManager,
'' as FDistrictAssistant,
s.FShopName,
s.FMTDistrict as FSaleDivision,
s.FShopProvince ,
s.FShopCity,
case i.fbrand when '自然堂' then s.FZRTSupplierCode else s.FCXSupplierCode end as FSupplierCode,
case i.fbrand when '自然堂' then s.FZRTSupplierName else  s.FCXSupplierName end  as FSupplierName,
case i.fbrand when '自然堂' then s.FZRTSupplierShortName else s.FCXSupplierShortName end as FSupplierShortName,
f.FItemNo as FProductNo,
i.FSapCode as FSAPItemNo,
i.fitemname as FProductName,
i.fbarcode as FQRCode,
i.fbrand as FBrandName,
i.fcategory as FItemCategory,
i.fseries as FItemSeries,
i.fsubcategory as FSubCategory,
i.fsalePrice as FStandardRetailPrice,
Fqty  as  FSaleQty,
FNetSaleAmt as FExcludeTaxSaleAmt,
FSaleAmt as  FIncludeTaxSaleAmt  ,
Fqty*i.fsalePrice    as  FOriginalRetailAmt,
FInvoiceCreateDateRange   ,
'' as FSalePackStyle
from t_nka_src_watsons f
left join t_nka_watsons_shopList s
on f.FShopNo = s.FShopNo
left join t_nka_item i
on f.FItemNo = i.FItemNo

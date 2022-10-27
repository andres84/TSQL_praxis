SELECT [Date]
      ,[Website]
      ,[Product]
      ,[Quantity]
      ,[RevenueDiscount]
      ,[NetStandardCost]
      ,[CountryCode]
  FROM [POND.HIGHLINE.EDU].[boomdata].[dbo].[fTransactions]
GO

use datos1
select * from dbo.dataDepartamento

select top 3 * from [POND.HIGHLINE.EDU].[boomdata].[dbo].[fTransactions]

select top 3 dd.nombre_departamento, dd.nombre_municipio, lined.Product
	
from

dbo.dataDepartamento dd
inner join [POND.HIGHLINE.EDU].[boomdata].[dbo].[fTransactions] lined on
lined.Quantity = dd.id
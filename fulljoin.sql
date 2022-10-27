select top 3 * from dbo.DatosBD1
BEGIN TRANSACTION
insert into pruebaExcel2.dbo.DatosBD2 (
ID,Year_Birth, Education, Marital_Status, Income, Kidhome, Teenhome, Dt_Customer,
Recency, MntWines, MntFruits, MntMeatProducts, MntFishProducts, MntSweetProducts, MntGoldProds
) values(
9858, 2016, 'Ph.D', 'casado', 4700000, 4, 0, '2022-10-11', 58, 5, 5, 5, 5, 5, 5
)
commit transaction

BEGIN TRANSACTION
insert into dbo.DatosBD1 (
ID,Year_Birth, Education, Marital_Status, Income, Kidhome, Teenhome, Dt_Customer,
Recency, NumDealsPurchases, NumWebPurchases, NumCatalogPurchases, NumStorePurchases
) values(
9993, 2016, 'Ph.D', 'casado', 4700000, 4, 0, '2022-10-11', 58, 5, 5, 5, 5
)
commit transaction

select id, Education, Marital_Status from pruebaExcel2.dbo.DatosBD2 where ID = 9857

select * from DatosBD1
select * from pruebaExcel2.dbo.DatosBD2

select * from DatosBD1 bd1
full join pruebaExcel2.dbo.DatosBD2 bd2 on bd2.ID = bd1.ID


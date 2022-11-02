-- listar las tablas de una BD
select * from INFORMATION_SCHEMA.TABLES

select * from SalesLT.Product

-- muestra el precio mayor de la columna ListPrice
select max(ListPrice) as precio_mayor from SalesLT.Product

-- muestra el precio minimo de la columna ListPrice
select min(ListPrice) as precio_minimo from SalesLT.Product

--muestra el valor promedio de la columna
select AVG(ListPrice) as precio_promedio from SalesLT.Product

--distinct Descarta duplicidad en una columna
select distinct Color from SalesLT.Product --sin distinct select select Color from SalesLT.Product

--sum() suma los valores de una columna
select sum(ListPrice) * sum(StandardCost) as Total_lista_precios_costo_estandard from SalesLT.Product

-- filtro por precio especifico
select * from SalesLT.Product as p where p.ListPrice = 9.5
select * from SalesLT.Product as p where p.ListPrice < 9.5

--muestra filtro de productos que comienzan por la letra A o terminan con la letra A
select p.Name, p.ListPrice from SalesLT.Product as p where p.Name like 'A%'
select p.Name, p.Color, p.ListPrice from SalesLT.Product as p where p.Name like '%A'
select * from SalesLT.Product as p where p.Name like '[A-D]%'
order by p.Name asc

--in verifica si ProductID contiene 711, 712, 713
select * from SalesLT.Product as p where p.ProductID in (800, 712, 713)
order by p.ProductID asc

select * from SalesLT.Product as p where p.Color in ('Red','Yellow')

-- muestra los precios que se encuentren entre 3 y 70
select p.Name, p.ListPrice from SalesLT.Product as p where p.ListPrice between 3 and 70
order by p.ListPrice

-- muestra los valores nulos y no nulos de la columna Size
select p.Name, p.Size from SalesLT.Product as p where p.Size is not null
order by p.Size

select p.Name, p.Size from SalesLT.Product as p where p.Size is null


-- selecciona los datos de la columna ModifiedDate por año, mes y dia
select * from SalesLT.Customer as p where year(p.ModifiedDate) = 2008 or YEAR(p.ModifiedDate) = 2007
order by p.ModifiedDate

select * from SalesLT.Customer as p where MONTH(p.ModifiedDate) = 4 or MONTH(p.ModifiedDate) = 3
order by p.ModifiedDate

select * from SalesLT.Customer as p where DAY(p.ModifiedDate) = 1 or DAY(p.ModifiedDate) = 3
order by p.ModifiedDate

select * from SalesLT.Customer as p 
where YEAR(p.ModifiedDate) = 2005 and MONTH(p.ModifiedDate) = 9 and DAY(p.ModifiedDate) = 1

-- actualiza el nombre de un producto
select * from SalesLT.Product

update SalesLT.Product 
set Name = 'HL Road Frame Black, 58'
where ProductID = 680

-- aplica el 10% al producto en el campo StandardCost
update SalesLT.Product
set StandardCost = StandardCost * 1.1
where ProductID = 680

-- aplica el 10% a todos los productos en el campo StandardCost
update SalesLT.Product
set StandardCost = StandardCost * 1.1

-- reduce a la mitad el StandardCost del producto
update SalesLT.Product
set StandardCost = StandardCost * 0.5
where ProductID = 680

-- elimina la tabla
drop table SalesLT.Product

-- elimina todos los registros de una tabla
truncate table SalesLT.Product

--elimina un registro especifico de la tabla
delete from SalesLT.Product where ProductID = 706

--consultas y subconsultas
--seleccionar los productos cuyo valor del costo estandar sea mayor al promedio de todos los productos
select * from SalesLT.Product
select AVG(p.StandardCost) as promedio_costo_estandar from SalesLT.Product as p

select * from SalesLT.Product as p 
where p.standardcost > (select AVG(pr.standardcost) from SalesLT.Product as pr)
order by p.standardcost desc

--asigna valores aleatorios
update SalesLT.Customer
set edad  = ABS(CAST(NEWID() as binary(6)) % 100) + 1

--otro ejemplo
DECLARE @Upper INT
DECLARE @Lower INT
DECLARE @Value INT
SET @Lower = 0 ---- Minimo
SET @Upper = 999 ---- Maximo
SET @Value=ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
declare @tablaProducto Table(

	producto int

)

insert into @tablaProducto values(@Value)
insert into @tablaProducto values(@Value)
insert into @tablaProducto values(@Value)

select * from @tablaProducto


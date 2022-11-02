-- listar las tablas de una BD
select * from INFORMATION_SCHEMA.TABLES

-- contar cuantos usuario tiene la BD
select count(u.CustomerID) as total_clientes from SalesLT.Customer u

-- 3. muestra el precio mayor de la columna StandardCost
select max(p.StandardCost) as precio_mayor from SalesLT.Product p

-- 4. muestra el precio minimo de la columna StandardCost de la tabla producto

select MIN(p.StandardCost) as precio_minimo from SalesLT.Product p

-- 5. muestra el valor promedio de la columna StandardCost de la tabla producto

select AVG(p.StandardCost) as promedio from SalesLT.Product p

-- 6. muestra los colores de la columna Color sin duplicarlos de la tabla producto

select p.Color from SalesLT.Product p
select distinct p.Color from SalesLT.Product p

-- 7. muestra total suma de los valores de la columna StandardCost de la tabla producto

select SUM(p.StandardCost) as total_preciosStandard from SalesLT.Product p

-- 8. mostrar los productos con un precio standard mayor a 15
select p.Name, p.StandardCost from SalesLT.Product p 

select p.Name, p.StandardCost from SalesLT.Product p
where p.StandardCost > 15

-- 9. muestra filtro de productos que comienzan por la letra A,B,C y D
select p.Name from SalesLT.Product p
select p.Name from SalesLT.Product p where p.Name like '[A-D]%'

-- 10. verificar si ProductID contiene 711, 712, 713
select * from SalesLT.Product p where p.ProductID in (711, 712, 713)

-- 11. muestra los precios que se encuentren entre 3 y 70
select p.StandardCost from SalesLT.Product p where p.StandardCost between 3 and 70
order by p.StandardCost

-- 12. mustra la cantidad los valores nulos y no nulos de la columna Size
select p.Size from SalesLT.Product p where p.Size is not null
select count(p.ProductID) as cantidad_valores_no_nulos_size from SalesLT.Product p where p.Size is null
select count(p.ProductID) as cantidad_valores_nulos_size from SalesLT.Product p where p.Size is not null

-- 13. aplica el 15% al producto 712 y el 20% al producto 831 en el campo StandardCost tabla producto
select * from SalesLT.Product
select p.Name, p.StandardCost from SalesLT.Product p where p.ProductID = 831

update SalesLT.Product
set StandardCost = StandardCost * 1.2
where ProductID = 831

-- 14. crear tabla temporal, registrar productos y luego insertarlos a otra tabla temporal por subconsulta
declare @tablaProducto Table(
	producto int
)

insert into @tablaProducto values(27)
insert into @tablaProducto values(39)
insert into @tablaProducto values(40)
insert into @tablaProducto values(16)

select * from @tablaProducto

declare @tablaAlterna Table(
	productoAlterno int
)

select * from @tablaAlterna

insert into @tablaAlterna select tp.producto from @tablaProducto tp

select * from @tablaAlterna

-- 15. crear tabla temporal, insertar 3 datos(codigo, nombre, precio), actualizar el registro de precio maximo aplicando el 44% a este por subconsulta

declare @tablaTemporal Table(
	codigo int,
	nombre varchar(10),
	precio float
)

insert into @tablaTemporal values (1,'andres', 500)
insert into @tablaTemporal values (2,'liliana', 300)
insert into @tablaTemporal values (3,'sara', 100)

select * from @tablaTemporal

update @tablaTemporal
set precio = precio * 1.44
where precio = (select max(precio) from @tablaTemporal)
select * from @tablaTemporal

-- 16. Generar joins de las tablas product, productCategory y SalesOrderDetail

select * from SalesLT.Product--mostrar nombre producto
select * from SalesLT.ProductCategory--mostrar categorias
select * from SalesLT.SalesOrderDetail-- mostrar precio por unidad

select p.Name as nombre_producto, pc.Name, sod.UnitPrice from SalesLT.Product p
inner join SalesLT.ProductCategory pc on pc.ProductCategoryID = p.ProductCategoryID
inner join SalesLT.SalesOrderDetail sod on sod.ProductID = p.ProductID

-- 17. muetra cuantos productos contiene la categoria Mountain Bikes

select count(p.ProductID) from SalesLT.Product p
inner join SalesLT.ProductCategory pc on pc.ProductCategoryID = p.ProductCategoryID
where pc.Name = 'Mountain Bikes'

-- 18. mostrar el precio por unidad para los productos de las categorias Road Bikes, Mountain Bikes, Brakes, Chains y Forks

select p.Name, sod.UnitPrice, pc.Name from SalesLT.Product p
inner join SalesLT.SalesOrderDetail sod on sod.ProductID = p.ProductID
inner join SalesLT.ProductCategory pc on pc.ProductCategoryID = p.ProductCategoryID
where pc.Name in ('Road Bikes','Mountain Bikes','Brakes','Chains', 'Forks')
order by pc.Name

-- 19. mostrar la diferencia entre el producto mas barato frente al mas caro del costo estandar del producto con id 711

declare @ProductoMasBarato float
declare @productoMasCaro float

set @productoMasCaro = (select MAX(p.StandardCost) from SalesLT.Product p)
set @ProductoMasBarato = (select MIN(p.StandardCost) from SalesLT.Product p)

--select p.Name, p.StandardCost as precio_producto, 
--@ProductoMasBarato as precio_mas_barato, 
--p.StandardCost - @ProductoMasBarato as diferencia_producto 
--from SalesLT.Product p
--where p.ProductID = 711

select p.Name, p.StandardCost as precio_producto, 
@productoMasCaro as precio_mas_caro, 
@productoMasCaro - p.StandardCost as diferencia_producto 
from SalesLT.Product p
where p.ProductID = 711

-- 20. actualizar el precio del producto con mayor valor aplicando el 75%

update SalesLT.Product
set StandardCost = (
select max(p.StandardCost) from SalesLT.Product p
)







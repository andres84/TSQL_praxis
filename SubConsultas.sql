--SUBCONSULTAS COMO EXPRESION
select * from SalesLT.Product

--mostrar la diferencia entre el producto mas barato frente al mas caro del costo estandar del producto con id 711

select p.ProductID, p.Name, p.StandardCost, 
	p.StandardCost - (select MAX(pro.StandardCost) from SalesLT.Product pro) as diferencia
from SalesLT.Product p
where p.ProductID = 711

--mostrar la diferencia entre el producto mas barato frente al mas caro del costo estandar del producto

select p.ProductID, p.Name, p.StandardCost, 
	p.StandardCost - (select max(pro.StandardCost) from SalesLT.Product pro) as diferencia 
from SalesLT.Product p

-- mostrar nombre, color del producto mas costoso

select p.Name, p.Color, p.StandardCost as mayor_precio from SalesLT.Product p
where p.StandardCost = (
	select max(pro.StandardCost) from SalesLT.Product pro
)

--actualizar el precio del producto con mayor valor a 2389
--prueba con variables
declare @tablaPrueba Table(
	valor int
)
insert into @tablaPrueba values(2388)
insert into @tablaPrueba values(2000)
--select * from @tablaPrueba
--select MAX(valor) from @tablaPrueba

update @tablaPrueba
set valor = 2389
where valor = (select max(valor) from @tablaPrueba)
select * from @tablaPrueba

--ejecucion en la tabla real
update SalesLT.Product
set StandardCost = 2389
where StandardCost = (select MAX(p.StandardCost) from SalesLT.Product p)

select p.Name, p.StandardCost 
from SalesLT.Product p 
where p.StandardCost = (
	select max(pro.StandardCost) from SalesLT.Product pro
)

--eliminar producto con el menor precio

--observamos el producto con el precio mas bajo
select p.Name, 
	(select min(pro.StandardCost) from SalesLT.Product pro) as precio_menor 
from SalesLT.Product p

--prueba con variables
declare @TablaPruebaEliminar Table(
	valorEliminar float
)
insert into @TablaPruebaEliminar values(0.9422)
insert into @TablaPruebaEliminar values(0.99)
select * from @TablaPruebaEliminar

delete from @TablaPruebaEliminar
where valorEliminar = (select min(valorEliminar) from @TablaPruebaEliminar)
select * from @TablaPruebaEliminar

-- ejecucion tabla real tener en cuenta la eliminacion en cascada cuando la tabla este relacionada con otras tablas
delete from SalesLT.Product
where StandardCost = (
	select min(StandardCost) from SalesLT.Product
)

--subconsultas con insert
--crearemos una tabla variable para realizar el ejercicio
select * from SalesLT.Product

declare @TablaTemporal Table(
	idProducto int,
	NombreProducto varchar(50),
	PrecioEstandar float
)

insert into @TablaTemporal
	select p.ProductID, p.Name, p.StandardCost from SalesLT.Product p

select * from @TablaTemporal

--otro ejercicio
declare @TablaTemporal2 Table(
	idProducto int,
	NombreProducto varchar(50),
	PrecioEstandar float
)

insert into @TablaTemporal2 
	select p.ProductID, p.Name, p.StandardCost from SalesLT.Product p
	where p.ProductID = 712

select * from @TablaTemporal2

--SUBCONSULTAS CON IN
select * from SalesLT.Product
select * from SalesLT.ProductCategory

--conocer los productos que se encuentran en la categoria Brakes
select p.Name, p.ProductCategoryID, pc.Name from SalesLT.Product p
inner join SalesLT.ProductCategory pc on pc.ProductCategoryID = p.ProductCategoryID
where pc.Name in (
	select pcs.Name from SalesLT.ProductCategory pcs where pcs.Name = 'Brakes'
)

--mostrar todas las categorias menos Brakes, Mountain Bikes, Chains, Road Bikes

select p.Name, p.ProductCategoryID, pc.Name from SalesLT.Product p
inner join SalesLT.ProductCategory pc on pc.ProductCategoryID = p.ProductCategoryID
where pc.Name not in (
	select pcs.Name from SalesLT.ProductCategory pcs where pcs.Name in ('Brakes', 'Chains', 'Mountain Bikes', 'Road Bikes')
)
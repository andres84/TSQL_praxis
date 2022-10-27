
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

--prueba en la tabla real
update SalesLT.Product
set StandardCost = 2389
where StandardCost = (select MAX(p.StandardCost) from SalesLT.Product p)

select p.Name, p.StandardCost 
from SalesLT.Product p 
where p.StandardCost = (
	select max(pro.StandardCost) from SalesLT.Product pro
)


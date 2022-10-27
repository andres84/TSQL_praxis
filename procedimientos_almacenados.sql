--listar productos
create proc spListar_Productos
as
select * from SalesLT.Product

--ejecutar procedimiento spListar_Productos
exec spListar_Productos


--otro procedimiento
create procedure spDetalleCategoria_porId
@IdCategoria int
as
select p.ProductID, pc.ProductCategoryID,p.Name nombre_producto, pc.Name as categoria from SalesLT.Product p
inner join SalesLT.ProductCategory pc on pc.ProductCategoryID = p.ProductCategoryID
where pc.ProductCategoryID = @IdCategoria

select * from SalesLT.ProductCategory
--ejecutar spDetalleCategoriaProducto
exec spDetalleCategoria_porId 37

--otro procedimiento
create procedure spDetalleProductoPorCategoria
@NombreCategoria varchar(20)
as
select p.Name, p.Color, p.ListPrice, pc.Name from SalesLT.Product p
inner join SalesLT.ProductCategory pc on pc.ProductCategoryID = p.ProductCategoryID
where pc.Name = @NombreCategoria

exec spDetalleProductoPorCategoria 'Mountain Bikes'

--otro procedimiento
create proc spRangoprecios
@precioInicial int,
@precioFinal int
as
select p.Name, p.Color, p.ListPrice from SalesLT.Product p
where p.ListPrice between @precioInicial and @precioFinal
order by p.ListPrice asc

exec spRangoprecios 21.24, 80

--declara un nuevo ID cada vez que se ejecuta
DECLARE @myid uniqueidentifier  
SET @myid = NEWID()  
PRINT 'Value of @myid is: '+ CONVERT(varchar(255), @myid)  

--- prueba almacenamiento proceso ingresar y actualizar usuario
create table usuario(
	id uniqueidentifier null,
	primerDato varchar(50) null,
	segundoDato varchar(50) null
)



--insertar
alter proc spInsertarDatosUsuario
@pkInicio int,
@pkFin int,
@riesgomax int

as

insert into dbo.usuario values(NEWID(), @pkInicio, @pkFin, @riesgomax, null)

exec spInsertarDatosUsuario 600, 699, 2

--actualizar
create proc spActualizarDatosUsuario
@id uniqueidentifier,
@primerDato varchar(50),
@segundoDato varchar(50)

as

update dbo.usuario
set primerDato = @primerDato,
	segundoDato = @segundoDato
where dbo.usuario.id = @id

exec spActualizarDatosUsuario '4CB474FA-FBA3-4C50-A7E3-05743629CE82', 'Liliana', 'Cantor Gómez'

-- ejercicio procesamiento almacenado
create database bodega

use bodega

create table producto(

idprod char(7) primary key not null,
descripcion varchar(25),
existencias int,
precio decimal(10,2),
preciov decimal(10,2),
ganancias as preciov-precio,
check(preciov>precio)
)

create table pedido(
idpedido char(7),
idprod char(7),
cantidad int,
foreign key (idprod) references producto(idprod)
)

insert into producto values('P1','Coca Cola',10,5,10)
insert into pedido values('PD1','P1',5)

-- EJ1 insertar producto por procedimiento almacenado
--crear un procedimiento almacenado que ingrese los valores en la tabla producto, y debera verificar que el codigo
--y el nombre del producto no exista para poder ingresarlo, en caso que el codigo o el nombre del producto
--ya exista enviar un mensaje que diga "ESTE PRODUCTO YA HA SIDO INGRESADO"
create proc spInsertar_producto
@idProducto char(7),
@descripcion varchar(25),
@existencias int,
@precio decimal(10,2),
@preciov decimal(10,2)
as
declare @total int --contador de resultados
select @total = count(idprod) from producto where idprod = @idProducto or descripcion = @descripcion
if(@total < 1) --no se encontraron resultados
	begin
		insert into producto values (@idProducto, @descripcion, @existencias, @precio, @preciov)
	end
else
	begin
		print 'ESTE PRODUCTO YA HA SIDO INGRESADO'
	end

exec spInsertar_producto 'P4', 'Papas', 20, 30, 35
select * from producto
select * from pedido

--EJ2
--Crear un procedimiento almacenado que permita realizar un pedido en la tabla pedido, este procedimiento debera verificar
--si el codigo del producto ingresado existe en la tabla producto en caso de que no se encuentre debera mostrar un mensaje
--asi como se muestra a continuacion "ESTE PRODUCTO NO EXISTE", ademas si la cantidad a pedir del producto es mayor a la existencia
--del producto debera mostrar un mensaje que diga "EXISTENCIA DEL PRODUCTO INSUFICIENTE".
--en caso que la cantidad a pedir sea menor o igual debera modificar/actualizar el valor de la existencia del producto
drop proc spInsertarPedido
create proc spInsertarPedido
@idpedido char(7),
@idproducto char(7),
@cantidad int
as
declare @total int --contador resultados
declare @exist int --existencias
declare @nuevacantidad int
select @total = count(idpedido) from pedido where idpedido = @idproducto
	
		if(@total < 1) --no se encontraron redultados
			begin
				select @total = count(idprod) from producto where idProd = @idproducto
				set @nuevacantidad = @exist - @cantidad --obteniendo la nueva cantidad
					if(@nuevacantidad >= 0) --hay stock suficiente
						begin
							insert into pedido values (@idpedido, @idproducto, @cantidad)
							update producto set existencias = @nuevacantidad where idProd = @idproducto
						end
					else
						begin
							print 'EXISTENCIA DEL PRODUCTO INSUFICIENTE'
						end
			end
		else
			begin
				print 'EL PRODUCTO NO EXISTE'
			end
	begin
		print 'YA EXISTE UN PEDIDO CON ESE ID'
	end




		select * from pedido
		select * from producto
		exec spInsertarPedido 'PD2', 'P3', 50

-------------------------------
--pasando una lista de valores a un procedimiento almacenado funcion STRING_SPLIT para SQLServer 2016 hacia delante
select * from string_split('Hola,Mundo',',')
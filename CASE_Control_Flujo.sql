create proc spCalcularPension
@idEmpleado int --declarar variable que capture el id al ejecutar el sp
as
declare @contador int -- contador que verifica si la tabla contiene datos
select @contador = count(emp.EmployeeID) from dbo.Employees emp where emp.EmployeeID = @idEmpleado
if(@contador >= 1)
	begin
		select
			(CAST(DATEDIFF(DD, e.BirthDate, GETDATE()) / 365.25 as int)) as edad,
			case
			when (CAST(DATEDIFF(DD, e.BirthDate, GETDATE()) / 365.25 as int)) > 70 then 'Jubilado'
			when (CAST(DATEDIFF(DD, e.BirthDate, GETDATE()) / 365.25 as int)) > 60 then 'Por retirarse'
			when (CAST(DATEDIFF(DD, e.BirthDate, GETDATE()) / 365.25 as int)) <= 60 then 'Faltan años por trabajar'		
			end as 'estado'
			from dbo.Employees e
			where e.EmployeeID = @idEmpleado
	end
else
	begin
		print 'el empleado con codigo ' + convert(varchar(50), @idEmpleado) + ', no existe'
	end

select em.EmployeeID, em.BirthDate from dbo.Employees em
exec spCalcularPension 6

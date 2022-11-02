declare @tablaTMP Table(
	nombre varchar(15),
	valor decimal(10,2)
)

insert into @tablaTMP values('andres', 203.22)
insert into @tablaTMP values('liliana', 407.25)
insert into @tablaTMP values('sara', 55.78)
insert into @tablaTMP values('isabella', 407.25)

select * from @tablaTMP

declare @tablaInsercion Table(
	nombreInsert varchar(15),
	valorInsert decimal(10,2)
)

select * from @tablaInsercion

insert into @tablaInsercion select nombre, valor from @tablaTMP

select * from @tablaInsercion

update @tablaInsercion
set valorInsert = valorInsert * 1.35
where valorInsert = (select max(valorInsert) from @tablaInsercion)

select * from @tablaInsercion




use datos1

-- unir registos de dos BD de una misma instancia
select 
	dd.nombre_departamento, dd.nombre_municipio, dm.habitantes
from dataDepartamento dd
inner join	datos2.dbo.dataMunicipio dm on dm.id = dd.id



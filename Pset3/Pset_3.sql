with recursive relation
as(select c.nome
from classificacao  c
where codigo_pai is null
union all
select c.nome
from classificacao c
inner join relation on codigo = codigo_pai
where codigo_pai is not null)
select codigo, codigo_pai, nome
from classificacao c ;

/*______________________________________________________________________________________________________________________________________*/

use elmasri;

 
/*______________________________________________________________________________________________________________________________________*/
/*questão 1*/
/*______________________________________________________________________________________________________________________________________*/


select avg(salario), numero_departamento
from funcionario
group by numero_departamento;



/*______________________________________________________________________________________________________________________________________*/
/*questão 2*/
/*______________________________________________________________________________________________________________________________________*/

select avg(salario), sexo
from funcionario
group by sexo;



/*______________________________________________________________________________________________________________________________________*/
/*questão 3*/
/*______________________________________________________________________________________________________________________________________*/

select d.nome_departamento,
		concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
        f.data_nascimento,
        f.salario,
		TIMESTAMPDIFF(YEAR,data_nascimento,now()) AS Idade 
        from departamento d
        inner join funcionario f on (f.numero_departamento=d.numero_departamento)
        order by d.nome_departamento;


/*______________________________________________________________________________________________________________________________________*/
/*questão 4*/
/*______________________________________________________________________________________________________________________________________*/


SELECT f.primeiro_nome 			AS		 	Nome,
		f.nome_meio 			AS 			Nome_meio,
		f.ultimo_nome 			AS 			Sobrenome,
        f.data_nascimento 		AS 			Nascimento,
         TIMESTAMPDIFF(YEAR,data_nascimento,now()) AS Idade ,
         f.salario 				AS 			Salario,
salario*1.2 AS aumento
FROM funcionario f
WHERE salario<30000 
UNION
(SELECT f.primeiro_nome			AS		 	Nome,
		f.nome_meio 			AS 			Nome_meio,
		f.ultimo_nome 			AS 			Sobrenome,
        f.data_nascimento 		AS 			Nascimento,
         TIMESTAMPDIFF(YEAR,data_nascimento,now()) AS Idade ,
         f.salario 				AS 			Salario,
salario*1.15 AS aumento
FROM  funcionario f
WHERE salario>30000
);




select concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
		TIMESTAMPDIFF(YEAR,data_nascimento,now()) AS Idade ,
        f.salario as salario,
       case 
			when salario<35000 then salario*(1.2)
            when salario>=35000 then salario*(1.15)
		end as salario_reajustado
from funcionario f;         
		
       
	
/*______________________________________________________________________________________________________________________________________*/
/*questão 5*/
/*______________________________________________________________________________________________________________________________________*/
select d.nome_departamento as departamento,
	concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
 case
	when d.numero_departamento = 1 then 'Jorge'
    when d.numero_departamento = 4 then 'Jennifer'
    when d.numero_departamento = 5 then 'Fernando'
end as Supervisor
from funcionario f
inner join departamento d on (f.numero_departamento=d.numero_departamento);		


			
        
/*______________________________________________________________________________________________________________________________________*/
/*questão 6*/
/*______________________________________________________________________________________________________________________________________*/

 select concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
		d.nome_departamento as departamento, 
        dp.nome_dependente,
        TIMESTAMPDIFF(YEAR,dp.data_nascimento,now()) AS Idade_dependente,
        case
			when dp.sexo='m' then 'masculino'
            when dp.sexo='f' then 'feminino'
            end sexo_dependente
from funcionario f 
inner join departamento d on (f.numero_departamento=d.numero_departamento)
inner join dependente dp on (f.cpf=dp.cpf_funcionario)
order by Nome_completo ;

/*______________________________________________________________________________________________________________________________________*/
/*questão 7*/
/*______________________________________________________________________________________________________________________________________*/

select concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
        f.numero_departamento 	as 		departamento,
		dp.nome_departamento 	as  	nome_departamento,
        f.salario 				as 		salario
        from funcionario f
        inner join departamento dp
        on f.numero_departamento = dp.numero_departamento
        where not exists (
			select * 
            from dependente d 
            where f.cpf=d.cpf_funcionario)
            order by departamento;
            
		select concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
        f.numero_departamento as departamento,
        f.salario as salario
        from funcionario f
        left outer join dependente dp on f.cpf=dp.cpf_funcionario
		where dp.cpf_funcionario is null;
        
        
        
/*funcionarios que tem filho*/
	select concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
	f.numero_departamento as departamento,
	f.salario as salario
	from funcionario f
	inner join dependente dp on f.cpf=dp.cpf_funcionario;
		
        
        
/*______________________________________________________________________________________________________________________________________*/        
/*questão 8*/
/*______________________________________________________________________________________________________________________________________*/

SELECT nome_departamento, nome_projeto, primeiro_nome, nome_meio, ultimo_nome, horas
FROM funcionario, departamento, projeto, trabalha_em
WHERE funcionario.cpf = trabalha_em.cpf_funcionario
AND trabalha_em.numero_projeto = projeto.numero_projeto
AND funcionario.numero_departamento = departamento.numero_departamento
ORDER BY departamento.numero_departamento, nome_projeto, primeiro_nome;


select concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
		nome_departamento as departamento,
		nome_projeto as projeto,
        horas as horas
from funcionario f, departamento d, projeto p, trabalha_em t
where f.cpf=t.cpf_funcionario and t.numero_projeto=p.numero_projeto
		and f.numero_departamento = d.numero_departamento
order by d.numero_departamento, projeto,Nome_completo;


            
		
/*______________________________________________________________________________________________________________________________________*/            
/*questão 9*/
/*______________________________________________________________________________________________________________________________________*/

select  sum(tm.horas) as horas_trabalhadas,
tm.numero_projeto as numero_projeto,
p.nome_projeto as nome_projeto,
d.nome_departamento as departamento
from trabalha_em tm
inner join projeto p on (p.numero_projeto=tm.numero_projeto)
inner join departamento d on (p.numero_departamento=d.numero_departamento)
where tm.numero_projeto=p.numero_projeto
group by departamento, nome_projeto, numero_projeto
order by numero_projeto;



/*______________________________________________________________________________________________________________________________________*/
/*questão 10*/
/*______________________________________________________________________________________________________________________________________*/
select avg(f.salario) as salario_medio,
        f.numero_departamento as departamento 
from funcionario f
where f.numero_departamento=f.numero_departamento
group by departamento;


/*______________________________________________________________________________________________________________________________________*/
/*questão 11*/
/*______________________________________________________________________________________________________________________________________*/
SELECT primeiro_nome, nome_meio, ultimo_nome, p.nome_projeto, horas * 50 as valor_horas
FROM funcionario join projeto as p join trabalha_em as t on (p.numero_projeto = t.numero_projeto)
WHERE funcionario.cpf = t.cpf_funcionario 
ORDER BY funcionario.primeiro_nome;



/*______________________________________________________________________________________________________________________________________*/
/*questão 12*/
/*______________________________________________________________________________________________________________________________________*/

select distinct concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
p.nome_projeto 				as		 projeto,
d.nome_departamento 		as 		departamento
from funcionario f
inner join projeto p on  ( f.numero_departamento=p.numero_departamento)
inner join departamento d on  ( f.numero_departamento=d.numero_departamento)
inner join trabalha_em t on  ( t.cpf_funcionario= f.cpf)
where t.horas is null ;
                   
/*______________________________________________________________________________________________________________________________________*/    
/*questão 13*/
/*______________________________________________________________________________________________________________________________________*/
   
   select f.primeiro_nome		as		 	Nome,
		f.nome_meio 			as 			Nome_meio,
		f.ultimo_nome 			as 			Sobrenome,
        f.sexo 					as 			sexo,
         TIMESTAMPDIFF(YEAR,f.data_nascimento,now()) as Idade_funcionario ,
         d.nome_dependente  as dependente,
         TIMESTAMPDIFF(YEAR,d.data_nascimento,now()) as Idade_dependente,
         d.sexo as sexo_dependente
         from funcionario f
         left join dependente d on (f.cpf=d.cpf_funcionario)
         order by Idade_funcionario desc;
/*______________________________________________________________________________________________________________________________________*/      
/*questão 14*/
/*______________________________________________________________________________________________________________________________________*/
SELECT f.numero_departamento, d.nome_departamento, COUNT(*) AS total_por_departamento 
FROM funcionario as f join departamento as d on (f.numero_departamento = d.numero_departamento)
GROUP BY numero_departamento;

/*______________________________________________________________________________________________________________________________________*/      
/*questão 15*/
/*______________________________________________________________________________________________________________________________________*/       

select concat(f.primeiro_nome,' ',f.nome_meio,' ',f.ultimo_nome) as Nome_completo,
		d.nome_departamento as departamento,
        p.nome_projeto
from trabalha_em as t 
left join projeto as p on (p.numero_projeto=t.numero_projeto)
join funcionario as f 
join departamento as d on (d.numero_departamento =f.numero_departamento)
where cpf_funcionario=f.cpf;			

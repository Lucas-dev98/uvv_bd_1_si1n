/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Criando o usurio lucas com todas as permissões--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE ROLE lucas WITH
	LOGIN
	SUPERUSER
	CREATEDB
	CREATEROLE
	INHERIT
	REPLICATION
	CONNECTION LIMIT -1;
COMMENT ON ROLE lucas IS 'criando o usuario dono do banco de dados ';




/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Criando o banco de dados uvv--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE DATABASE uvv
    WITH 
    OWNER = lucas
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'Portuguese_Brazil.1252'
    LC_CTYPE = 'Portuguese_Brazil.1252'
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE uvv
    IS 'criando banco de dados uvv';






/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Criando o schema do banco de dados uvv--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE SCHEMA elmasri
    AUTHORIZATION lucas;

COMMENT ON SCHEMA elmasri
    IS 'criando o schema elmari';

GRANT ALL ON SCHEMA elmasri TO lucas WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES IN SCHEMA elmasri
GRANT ALL ON TABLES TO lucas WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES IN SCHEMA elmasri
GRANT ALL ON SEQUENCES TO lucas WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES IN SCHEMA elmasri
GRANT EXECUTE ON FUNCTIONS TO lucas WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES IN SCHEMA elmasri
GRANT USAGE ON TYPES TO lucas WITH GRANT OPTION;







/*-----------------------------------------------------------------------------------------------------------------------------------------------
--selecão de esquema--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
SELECT CURRENT_SCHEMA();



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--mostrar a selecão de esquema--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
SHOW SEARCH_PATH;




/*-----------------------------------------------------------------------------------------------------------------------------------------------
--setar o schema para elmari--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
SET SEARCH_PATH TO elmasri, "\$user", public;


/*-----------------------------------------------------------------------------------------------------------------------------------------------
--mostrar a selecão de esquema--
-----------------------------------------------------------------------------------------------------------------------------------------------*/

SHOW SEARCH_PATH;



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--alterar usuario padrão do esquma para lucas--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
ALTER USER lucas
SET SEARCH_PATH TO elmasri, "\$user", public;



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--criando a tabela projeto no schema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE elmasri.projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto)
);
COMMENT ON TABLE elmasri.projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN elmasri.projeto.numero_projeto IS 'Número do projeto.É a PK da tabela';
COMMENT ON COLUMN elmasri.projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN elmasri.projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN elmasri.projeto.numero_departamento IS 'Número do departamento. É uma FK';


CREATE INDEX projeto_idx
 ON elmasri.projeto
 ( nome_projeto );

CREATE UNIQUE INDEX projeto_idx1
 ON elmasri.projeto
 ( nome_projeto );




/*-----------------------------------------------------------------------------------------------------------------------------------------------
--criando a tabela trabalha_em no schema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE elmasri.trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1),
                CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);
COMMENT ON TABLE elmasri.trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN elmasri.trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK';
COMMENT ON COLUMN elmasri.trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK da tabela e é uma FK.';
COMMENT ON COLUMN elmasri.trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';




/*-----------------------------------------------------------------------------------------------------------------------------------------------
--criando a tabela dependente no schema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE elmasri.dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT dependente_pk PRIMARY KEY (cpf_funcionario, nome_dependente)
);
COMMENT ON TABLE elmasri.dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN elmasri.dependente.cpf_funcionario IS 'PF do funcionário. Faz parte da PK desta tabela e é uma FK';
COMMENT ON COLUMN elmasri.dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN elmasri.dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN elmasri.dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN elmasri.dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';





/*-----------------------------------------------------------------------------------------------------------------------------------------------
--criando a tabela departamento no schema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/

CREATE TABLE elmasri.departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio DATE,
                CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento)
);
COMMENT ON TABLE elmasri.departamento IS 'Tabela que armazena as informaçoẽs dos departamentos.';
COMMENT ON COLUMN elmasri.departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN elmasri.departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN elmasri.departamento.cpf_gerente IS 'CPF do gerente do departamento. É uma FK';
COMMENT ON COLUMN elmasri.departamento.data_inicio IS 'Data do início do gerente no departamento.';


CREATE UNIQUE INDEX departamento_idx
 ON elmasri.departamento
 ( nome_departamento );

CREATE TABLE elmasri.localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT localizacoes_departamento_pk PRIMARY KEY (numero_departamento, local)
);
COMMENT ON TABLE elmasri.localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN elmasri.localizacoes_departamento.numero_departamento IS 'Número do departamento.Faz parta da PK da tabela e é uma FK';
COMMENT ON COLUMN elmasri.localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';





/*-----------------------------------------------------------------------------------------------------------------------------------------------
--criando a tabela funcionario no schema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/


CREATE TABLE elmasri.funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (cpf)
);
COMMENT ON TABLE elmasri.funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN elmasri.funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN elmasri.funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN elmasri.funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.data_nascimento IS 'Data de nascimento do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.endereco IS 'Endereço do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.salario IS 'Salário do funcionário.';
COMMENT ON COLUMN elmasri.funcionario.cpf_supervisor IS 'CPF do supervisor. Será um auto-relacionamento';
COMMENT ON COLUMN elmasri.funcionario.numero_departamento IS 'Número do departamento do funcionário.';


ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;






/*-----------------------------------------------------------------------------------------------------------------------------------------------
--inserindo os dados nas tuplas de funcionario do eschema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/


INSERT INTO elmasri.funcionario VALUES (
88866555576, 'Jorge' , 'E' , 'Brito' , '1937-11-10' 
		,'R.do Horto,35,São Paulo,SP','M',55000.00, NULL, 1);
		
		
	INSERT INTO elmasri.funcionario VALUES (
98765432168, 'Jennifer' , 'S' , 'Souza' , '1941-06-20' 
			,'Av.Art.deLima,54,SantoAndré,SP','F',43000.00, 88866555576, 4);
			
INSERT INTO elmasri.funcionario VALUES (
33344555587, 'Fernando' , 'T' , 'Wong' ,
'1955-12-08' ,'R.da Lapa,34,São Paulo,SP','M', 40000.00, 88866555576, 5);

INSERT INTO elmasri.funcionario VALUES (
98798798733, 'André' , 'V' , 'Pereira' ,
'1969-03-29' ,'RuaTimbira,35,São Paulo,SP','M',25000.00, 98765432168, 4);


INSERT INTO elmasri.funcionario VALUES (
45345345376, 'Joice' , 'A' , 'Leite' ,
'1972-07-31' ,'Av.Lucas Obes,74,São Paulo,SP','F',25000.00, 33344555587, 5);


INSERT INTO elmasri.funcionario VALUES (
66688444476, 'Ronaldo' , 'K' , 'Lima' ,
'1962-09-15' ,'Rua Rebouças,65,Piracicaba, SP','M',38000.00, 33344555587, 5);


INSERT INTO elmasri.funcionario VALUES (
12345678966, 'Joao', 'B', 'Silva',
'1965-01-09', 'R. das Flores,751.São Paulo,SP', 'M', 30000.00, 33344555587, 5);


INSERT INTO elmasri.funcionario VALUES (
99988777767, 'Alice' , 'J' , 'Zelaya' ,
'1968-01-19' ,'R.Souza Lima,35,Curitiba,PR','F',25000.00, 98765432168, 4);






/*-----------------------------------------------------------------------------------------------------------------------------------------------
--inserindo os dados nas tuplas de localizacoes_departamento do eschema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/

INSERT INTO elmasri.localizacoes_departamento VALUES (
1, 'São Paulo');
INSERT INTO elmasri.localizacoes_departamento VALUES (
4, 'Mauá');
INSERT INTO elmasri.localizacoes_departamento VALUES (
5 , 'SantoAndré');
INSERT INTO elmasri.localizacoes_departamento VALUES (
5, 'Itu');
INSERT INTO elmasri.localizacoes_departamento VALUES (
5, 'São Paulo');





/*-----------------------------------------------------------------------------------------------------------------------------------------------
--inserindo os dados nas tuplas de projeto do eschema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/


INSERT INTO elmasri.projeto VALUES (1, 'ProdutoX', 'SantoAndré', 5 );
INSERT INTO elmasri.projeto VALUES (2, 'ProdutoY', 'Itu', 5 );
INSERT INTO elmasri.projeto VALUES (3, 'ProdutoZ', 'São_Paulo', 5 );
INSERT INTO elmasri.projeto VALUES (10, 'Informatização', 'Mauá', 4 );
INSERT INTO elmasri.projeto VALUES (20, 'Reorganização','São_Paulo', 1 );
INSERT INTO elmasri.projeto VALUES (30, 'Novosbeneficios', 'Mauá', 4 );





/*-----------------------------------------------------------------------------------------------------------------------------------------------
--inserindo os dados nas tuplas de dependente do eschema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
INSERT INTO elmasri.dependente VALUES (33344555587, 'Alicia', 'F', '1986-04-05', 'filha');
INSERT INTO elmasri.dependente VALUES (33344555587, 'Tiago', 'M', '1983-10-25', 'filho');
INSERT INTO elmasri.dependente VALUES (33344555587, 'Janaína', 'F', '1958-05-03' , 'Esposa');
INSERT INTO elmasri.dependente VALUES (98765432168, 'Antonio', 'M', '1942-02-28' , 'Marido');
INSERT INTO elmasri.dependente VALUES (12345678966, 'Michael', 'M', '1988-01-04' , 'Filho');
INSERT INTO elmasri.dependente VALUES (12345678966, 'Alicia', 'F', '1988-12-30' , 'Filha');
INSERT INTO elmasri.dependente VALUES (12345678966, 'Elizabeth', 'F', '1967-05-05' , 'Esposa');




/*-----------------------------------------------------------------------------------------------------------------------------------------------
--inserindo os dados nas tuplas de departamento do eschema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/


INSERT INTO elmasri.departamento VALUES (5, 'Pesquisa', 33344555587, '1988-05-22');
INSERT INTO elmasri.departamento VALUES (4, 'Administração', 98765432168 ,'1995-01-01');
INSERT INTO elmasri.departamento VALUES (1, 'Matriz', 88866555576, '1981-06-19');




/*-----------------------------------------------------------------------------------------------------------------------------------------------
--inserindo os dados nas tuplas de trabalha_em do eschema elmasri--
-----------------------------------------------------------------------------------------------------------------------------------------------*/
INSERT INTO elmasri.trabalha_em VALUES (12345678966, 1, 32.5 );
INSERT INTO elmasri.trabalha_em VALUES (12345678966, 2, 7.5);
INSERT INTO elmasri.trabalha_em VALUES (66688444476 , 3, 40.0);
INSERT INTO elmasri.trabalha_em VALUES (45345345376, 1, 20.0);
INSERT INTO elmasri.trabalha_em VALUES (45345345376, 2, 20.00);
INSERT INTO elmasri.trabalha_em VALUES (33344555587, 2, 10.0);
INSERT INTO elmasri.trabalha_em VALUES (33344555587, 3, 10.0);
INSERT INTO elmasri.trabalha_em VALUES (33344555587, 10, 10.0);	
INSERT INTO elmasri.trabalha_em VALUES (33344555587, 20, 10.0);
INSERT INTO elmasri.trabalha_em VALUES (99988777767, 30, 30.0);
INSERT INTO elmasri.trabalha_em VALUES (99988777767, 10, 10.0);
INSERT INTO elmasri.trabalha_em VALUES (98798798733, 10, 35.0);
INSERT INTO elmasri.trabalha_em VALUES (98798798733, 30, 5.0);
INSERT INTO elmasri.trabalha_em VALUES (98765432168, 30, 20.0);
INSERT INTO elmasri.trabalha_em VALUES (98765432168, 20, 15.0);
INSERT INTO elmasri.trabalha_em VALUES (88866555576, 10, null);





/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Adicionando a foreign key em cpf_gerente de departamento referente a funcionario --
-----------------------------------------------------------------------------------------------------------------------------------------------*/
ALTER TABLE elmasri.departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Adicionando a foreign key em cpf_funcionario de dependente referente a funcionario --
-----------------------------------------------------------------------------------------------------------------------------------------------*/
ALTER TABLE elmasri.dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Adicionando a foreign key em cpf_funcionario de trabalha_em referente a funcionario --
-----------------------------------------------------------------------------------------------------------------------------------------------*/

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Adicionando a foreign key em cpf_supervisor de funcionario referente a funcionario --
-----------------------------------------------------------------------------------------------------------------------------------------------*/
ALTER TABLE elmasri.funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES elmasri.funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Adicionando a foreign key em numero_departamento de localizacoes_departamento referente a departamento--
-----------------------------------------------------------------------------------------------------------------------------------------------*/

ALTER TABLE elmasri.localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Adicionando a foreign key em numero_departamento de projeto referente a departamento--
-----------------------------------------------------------------------------------------------------------------------------------------------*/

ALTER TABLE elmasri.projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Adicionando a foreign key em numero_departamento de funcionario referente a departamento--
-----------------------------------------------------------------------------------------------------------------------------------------------*/

ALTER TABLE elmasri.funcionario ADD CONSTRAINT departamento_funcionario_fk
FOREIGN KEY (numero_departamento)
REFERENCES elmasri.departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;



/*-----------------------------------------------------------------------------------------------------------------------------------------------
--Adicionando a foreign key em numero_projeto de trabalha_em referente a projeto --
-----------------------------------------------------------------------------------------------------------------------------------------------*/

ALTER TABLE elmasri.trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES elmasri.projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;







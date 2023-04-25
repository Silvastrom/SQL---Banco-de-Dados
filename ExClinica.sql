Create table clinica
GO
USE clinica

CREATE TABLE Paciente(
num_beneficiario int          not null,
nome		     varchar(100) not null,
logadouro        varchar(200) not null,
numero           int          not null,
CEP              char(8)      not null,
complemento      varchar(255) not null,
telefone         varchar(11)  not null,
primary key (num_beneficiario)
)

CREATE TABLE especialidade (
id				INT				NOT NULL,
especialidade	VARCHAR(100)	NOT NULL
PRIMARY KEY(id)
)
go
create table Medico(
Codigo			 int	      not null,
nome			 varchar(100) not null,
logadouro        varchar(200) not null,
numero           int          not null,
CEP              char(8)      not null,
complemento      varchar(255) not null,
contato			 varchar (11) not null,
especialidadeID  int          not null
Primary key (Codigo)
Foreign key (especialidadeID) references especialidade(id)
)

Create table consulta(
Paciente_num_beneficiario int not null,
Medico_Codigo int not null,
Data_hora datetime not null,
observacao varchar(255)
Primary key (Paciente_num_beneficiario,Medico_Codigo, data_hora )
Foreign key (paciente_num_beneficiario) references paciente (num_beneficiario),
foreign key (medico_codigo)references medico(codigo)
)

insert into paciente (num_beneficiario,nome,logadouro,numero,CEP,complemento,telefone)values
(99901, 'Washington Silva', 'R. Anhaia', 150, '02345000', 'Casa','922229999'),
(99902, 'Luis Ricardo', 'R.Voluntários da Pátria',2251,03254010,'Bloco B Apto 25','92340987'),
(99903,'Maria Elisa','Av. Aguia de Haia',1188,0698702,'Apto 1208','91238765'),
(99904, 'Jose Araujo','R.XV de nobembro',18,03678000,'casa','945674321'),
(99905, 'Joana Paula','R. 7 de Abril',97,01214000,'Conjunto 3- apto 801','912095674')

insert into medico(codigo,nome,logadouro,numero,cep,complemento,contato,especialidadeID)values
(100001,'Ana Paula','R.7 de Setembro',256,03698000,'casa','915689456',1),
(100002,'Maria Aparecida','Av. Brasil',32,02145070,'casa','923235454',1),
(100003,'Lucas Borges','Av. do Estado',3210,05241000,'Apto 205','963698585',2),
(100004,'Gabriel Oliveira','Av. Dom Helder Camara',350,03145000,'Apto 602','932458745',3)

insert into especialidade(id,especialidade) values
(1,'Otorrinolaringologista'),(2,'urologista'),(3,'Geriatra'),(4,'Pediatra')

insert into consulta(Paciente_num_beneficiario,Medico_Codigo,Data_hora,observacao) values
(99901,100002,'2021-09-04 13:20','infecção Urinaria'),
(99902,100003,'2021-09-04 13:15','Gripe'),
(99901,100001,'2021-09-04 12:30','infecção garganta')

alter table medico
add dia_atendimento varchar(100)

update medico 
set dia_atendimento ='2° feira'
where codigo=100001

update medico 
set dia_atendimento ='4° feira'
where codigo=100002

update medico 
set dia_atendimento ='2° feira'
where codigo=100003

update medico 
set dia_atendimento ='5° feira'
where codigo=100004

delete especialidade
where id=4

exec sp_rename 'medico.dia_atendimento','dia_semana_atendimento','COLUMN'

UPDATE Medico
Set logadouro='Av. Bras Leme',numero=876,complemento='apto 504',CEP=02122000
where Codigo = 100003

ALTER TABLE consulta
ALTER COLUMN observacao VARCHAR(200) not NULL
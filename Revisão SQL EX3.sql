create database ex004 
GO
Use ex004
GO

CREATE TABLE Paciente (
	CPF CHAR(11) not null,
	Nome VARCHAR(100) not null,
	Rua VARCHAR(100) not null,
	N int not null,
	Bairro VARCHAR(20) not null,
	Telefone CHAR(8) not null,
	Data_Nasc date
	Primary Key (CPF)
)
GO

CREATE TABLE Medico (
	Codigo int not null,
	Nome VARCHAR(100) not null,
	Especialidade VARCHAR(20) not null
	Primary Key (Codigo)
)
GO



CREATE TABLE Prontuario (
	DataP date not null,
	CPF_Paciente CHAR(11) not null,
	Codigo_Medico int not null,
	Diagnostico VARCHAR(20) not null,
	Medicamento VARCHAR(30) not null
	Primary Key (DataP,CPF_Paciente,Codigo_Medico)
	Foreign Key (CPF_Paciente) REFERENCES Paciente(CPF),
	Foreign Key (Codigo_Medico) REFERENCES Medico(Codigo)
)
GO

alter table Prontuario
alter column 	Diagnostico VARCHAR(30) not null


Alter table Paciente
alter column Telefone CHAR(8) 

select * from Medico
select * from Paciente
Select * from Prontuario

--Consultar:
--Nome e Endere�o (concatenado) dos pacientes com mais de 50 anos
SELECT Nome, Rua + ' ' + 'N�' + CAST( N AS varchar(10)) + ' ' + Bairro  AS Endere�o FROM Paciente 
WHERE DATEDIFF (year, Data_nasc, GETDATE()) >= 50

--Qual a especialidade de Carolina Oliveira
SELECT Especialidade FROM Medico WHERE Nome LIKE 'Carolina Oliveira'

--Qual medicamento receitado para reumatismo
SELECT Medicamento FROM Prontuario WHERE Diagnostico LIKE 'Reumatismo' 

--Consultar em subqueries:
--Diagn�stico e Medicamento do paciente Jos� Rubens em suas consultas
SELECT Prontuario.Diagnostico, Prontuario.Medicamento FROM Prontuario INNER JOIN Paciente 
ON  Prontuario.CPF_paciente = Paciente.CPF WHERE Nome LIKE 'Jos�%'


--Nome e especialidade do(s) M�dico(s) que atenderam Jos� Rubens. 
--Caso a especialidade tenha mais de 3 letras, mostrar apenas as 3 primeiras letras concatenada com um ponto final (.)

SELECT Medico.Nome, SUBSTRING(Medico.Especialidade, 1, 3) + '.' AS Especialidade FROM Medico INNER JOIN Prontuario 
ON Medico.Codigo = Prontuario.Codigo_medico INNER JOIN Paciente 
ON Paciente.CPF = Prontuario.CPF_paciente WHERE Paciente.Nome LIKE 'Jos�%' 

--CPF (Com a m�scara XXX.XXX.XXX-XX), Nome, Endere�o completo (Rua, n� - Bairro), 
--Telefone (Caso nulo, mostrar um tra�o (-)) dos pacientes do m�dico Vinicius
SELECT SUBSTRING(P.CPF,  1, 3) + '.' + SUBSTRING(P.CPF,  4, 3) + '.' + SUBSTRING(P.CPF,  5, 3) + '-' + SUBSTRING(P.CPF,  7, 2)  AS CPF,
	p.Nome, (p.Rua + ', N� ' + CAST( p.N AS varchar(10)) + ' ' + p.Bairro) AS Endere�o,
	Telefone
	FROM Paciente p inner join Prontuario pr ON p.CPF = pr.CPF_Paciente
	inner join Medico m ON m.Codigo = pr.Codigo_Medico
WHERE m.Nome LIKE 'Vinicius%'

--Quantos dias fazem da consulta de Maria Rita at� hoje

SELECT p.Nome,DATEDIFF(DAY, pr.DataP,GETDATE()) AS DIAS_CONSULTA
FROM Paciente p inner join Prontuario pr ON p.CPF = pr.CPF_Paciente
WHERE p.Nome like 'Maria Rita%'

--Alterar o telefone da paciente Maria Rita, para 98345621

Update Paciente
set Telefone = '98345621'
where Nome like 'Maria Rita%'

--Alterar o Endere�o de Joana de Souza para 
--Volunt�rios da P�tria, 1980, Jd. Aeroporto

Update Paciente
set Rua = 'Volunt�rios da P�tria', N = 1980 , Bairro = 'Jd. Aeroporto'
where Nome like 'Joana de Souza%'
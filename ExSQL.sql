
--a) Fazer um algoritmo que leia 1 número e mostre se são múltiplos de 2,3,5 ou nenhum deles

DECLARE @num INT, @result VARCHAR(30)
SET @num = 7
SET @result = ' '
IF ((SELECT (@num % 2)) = 0)
BEGIN
	PRINT('Múltiplo de 2')
	SET @result = '-'
END
IF ((SELECT (@num % 3)) = 0)
BEGIN
	PRINT('Múltiplo de 3')
	SET @result = '_'
END
IF ((SELECT (@num % 5)) = 0)
BEGIN
	PRINT('Múltiplo de 5')
	SET @result = '_'
END
IF (@result = ' ')
BEGIN
	PRINT('Não é múltiplo de 2, 3 e 5')
END


--b) Fazer um algoritmo que leia 3 números e mostre o maior e o menor

DECLARE @num1 INT, @num2 INT, @num3 INT, @maior INT, @menor INT
SET @num1 = 1
SET @num2 = 2
SET @num3 = 3

IF (@num3 > @num1 AND @num3 > @num2)		
BEGIN
	SET @maior = @num3
	SET @menor = @num1
	IF (@num1 > @num2)
	BEGIN
		SET @menor = @num2
	END
END
ELSE IF (@num2 > @num1)
BEGIN
	SET @maior = @num2
	SET @menor = @num1
	IF (@num1 > @num3)
	BEGIN
		SET @menor = @num3
	END
END
ELSE
BEGIN
	SET @maior = @num1
	SET @menor = @num2
	IF (@num2 > @num3)
	BEGIN
		SET @menor = @num3
	END
END
PRINT( 'Maior: ' + CAST(@maior AS VARCHAR(9)) + ' Menor: ' + CAST(@menor AS VARCHAR(9)) )


--c) Fazer um algoritmo que calcule os 15 primeiros termos da série
--1,1,2,3,5,8,13,21,...
--E calcule a soma dos 15 termos

DECLARE @soma INT, @anterior INT, @proximo INT, @cont INT, @temp INT
SET @anterior = 0
SET @proximo = 1
SET @cont = 0
SET @soma = 0
WHILE (@cont < 15)
BEGIN
	PRINT(@proximo)
	SET @temp = @proximo
	SET @soma = @proximo + @soma
	SET @proximo = @proximo + @anterior
	SET @anterior = @temp
	SET @cont = @cont + 1
END
PRINT ('A soma é: ' + CAST(@soma AS VARCHAR(5)))


--d) Fazer um algoritmo que separa uma frase, colocando todas as letras em maiúsculo e em
--minúsculo (Usar funções UPPER e LOWER)

DECLARE @frase VARCHAR(100)
SET @frase = 'Não sei o que lá'
PRINT ('Letras em minúsculo: ' + LOWER(@frase))
PRINT ('Letras em maiúsculo: ' + UPPER(@frase))


--e) Fazer um algoritmo que inverta uma palavra (Usar a função SUBSTRING)

DECLARE @palavra VARCHAR(50), @i INT, @novapalavra VARCHAR(50)
SET @palavra = 'Paralelepípedo'
SET @i = 0
SET @novapalavra = ' '
WHILE (@i < LEN(@palavra))
BEGIN
	SET @novapalavra = @novapalavra + SUBSTRING(@palavra, LEN(@palavra) - @i, 1)
	SET @i = @i + 1
END
PRINT(LOWER(@novapalavra))

--f) Considerando a tabela abaixo, gere uma massa de dados, com 100 registros, para fins de teste
--com as regras estabelecidas (Não usar constraints na criação da tabela)
--Computador
--ID         Marca           QtdRAM         TipoHD               QtdHD       FreqCPU
--INT(PK)    VARCHAR(40)      INT            VARCHAR(10)          INT        DECIMAL(7,2)

--• ID incremental a iniciar de 10001
--• Marca segue o padrão simples, Marca 1, Marca 2, Marca 3, etc.
--• QtdRAM é um número aleatório* dentre os valores permitidos (2, 4, 8, 16)
--• TipoHD segue o padrão:
--o Se o ID dividido por 3 der resto 0, é HDD
--o Se o ID dividido por 3 der resto 1, é SSD
--o Se o ID dividido por 3 der resto 2, é M2 NVME
--• QtdHD segue o padrão:
--o Se o TipoHD for HDD, um valor aleatório* dentre os valores permitidos (500, 1000 ou 2000)
--o Se o TipoHD for SSD, um valor aleatório* dentre os valores permitidos (128, 256, 512)
--• FreqHD é um número aleatório* entre 1.70 e 3.20

--* Função RAND() gera números aleatórios entre 0 e 0,9999...
CREATE DATABASE informatica
USE informatica
CREATE TABLE computador (
	id	INT, marca VARCHAR(40), qtdRam INT, tipoHD VARCHAR(10), qtdHD INT, freqCPU DECIMAL(7,2),
	PRIMARY KEY (id)
)

DECLARE @id INT, @marca VARCHAR(40), @qtdRam INT, @tipoHD VARCHAR(10), @qtdHD INT, @freqCPU DECIMAL(7,2), @count INT
SET @count = 1
WHILE(@count <= 100)
BEGIN 
	SET @id = 10000 + @count
	SET @tipoHD = CASE(@id % 3)
				WHEN 0 THEN 'HDD'
				WHEN 1 THEN 'SSD'
				WHEN 2 THEN 'M2 NVME'
				END
	SET @qtdRam = CASE(ROUND(1 + (RAND() * 3) , 0))
						WHEN 1 THEN 2
						WHEN 2 THEN 4
						WHEN 3 THEN 8
						ELSE 16
						END
	IF (@tipoHD = 'HDD')
	BEGIN
		SET @qtdHD = CASE(ROUND(1 + RAND() * 3 , 0))
						WHEN 1 THEN 500
						WHEN 2 THEN 1000
						ELSE 2000
						END
	END
	ELSE
	BEGIN
		SET @qtdHD = CASE(ROUND(RAND() * 3 + 1, 0))
						WHEN 1 THEN 128
						WHEN 2 THEN 256
						ELSE 512
						END
	END
	SET @freqCPU = 1.70 + (RAND() * (3.20 - 1.70))
	INSERT INTO computador(id, marca, qtdRam, tipoHD, qtdHD, freqCPU)
	VALUES (@id, 'MARCA ' + CAST(@count AS VARCHAR(3)), @qtdRam, @tipoHD, @qtdHD, @freqCPU)
	SET @count = @count + 1
END
				
SELECT * FROM computador
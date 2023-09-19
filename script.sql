-- 1.1 Resolva cada exercício a seguir usando LOOP, WHILE, FOR e FOREACH.
-- Quando o enunciado disser que é preciso “ler” algum valor, gere-o aleatoriamente.

CREATE OR REPLACE FUNCTION valor_aleatorio_entre (lim_inferior INT, lim_superior INT) RETURNS INT AS
$$
BEGIN
	RETURN FLOOR(RANDOM() * (lim_superior - lim_inferior + 1) + lim_inferior)::INT;
END;
$$ LANGUAGE plpgsql;

-- 1.1/1 Faça um programa que mostre os números pares entre 1 e 100, inclusive.
-- Entrada: Neste problema extremamente simples de repetição não há entrada.
-- Saída: Imprima todos os números pares entre 1 e 100, inclusive se for o caso, um em cada linha.

-- LOOP 

DO
$$
DECLARE
	contador INT := 1;
BEGIN
	LOOP
		IF contador % 2 = 0 THEN
		RAISE NOTICE '%', contador;
		END IF;
		contador := contador + 1;
		IF contador > 100 THEN EXIT;
		END IF;
	END LOOP;
END;$$

-- WHILE

DO
$$
DECLARE
	contador INT := 0;
BEGIN
	WHILE contador <= 100 LOOP
		IF contador % 2 = 0 THEN
		RAISE NOTICE '%', contador;
		END IF;
		contador := contador + 1;
	END LOOP;
END;
$$

-- FOR

DO
$$
BEGIN
	FOR i in 1..100 LOOP
		IF i % 2 = 0 THEN
		RAISE NOTICE '%', i;
		END IF;
	END LOOP;
END;
$$

-- FOREACH

DO
$$
DECLARE
	lista INT[] := ARRAY[]::integer[];
	valor INT;
BEGIN
	FOR i in 1..100 LOOP
		IF i % 2 = 0 THEN
		lista := array_append(lista, i);
		END IF;
	END LOOP;
	FOREACH valor IN ARRAY lista LOOP
		RAISE NOTICE '%', valor;
	END LOOP;
END;
$$

-- 1.1/2 Faça um programa que leia 6 valores. Estes valores serão somente negativos ou positivos (desconsidere os valores nulos). A seguir, mostre a quantidade de valores positivos digitados.
-- Entrada: Seis valores, negativos e/ou positivos.
-- Saída: Imprima uma mensagem dizendo quantos valores positivos foram lidos.

-- 1.1/3 Leia 2 valores inteiros X e Y. A seguir, calcule e mostre a soma dos números impares entre eles.
-- Entrada: O arquivo de entrada contém dois valores inteiros.
-- Saída: O programa deve imprimir um valor inteiro. Este valor é a soma dos valores ímpares que estão entre os valores fornecidos na entrada que deverá caber em um inteiro.

-- 1.1/4 Leia um conjunto não determinado de pares de valores M e N (parar quando algum dos valores for menor ou igual a zero). Para cada par lido, mostre a sequência do menor até o maior e a soma dos inteiros consecutivos entre eles (incluindo o N e M).
-- Entrada? O arquivo de entrada contém um número não determinado de valores M e N. A última linha de entrada vai conter um número nulo ou negativo.
-- Saída: Para cada dupla de valores, imprima a sequência do menor até o maior e a soma deles, conforme exemplo abaixo.

-- 1.2 Faça um programa que calcule o determinante de uma matriz quadrada de ordem 3 utilizando a regra de Sarrus.
-- Veja a regra aqui: https://en.wikipedia.org/wiki/Rule_of_Sarrus


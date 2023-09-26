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

-- LOOP

DO
$$
DECLARE
	contador INT := 0;
	valor INT;
	varLoop INT = 0;
BEGIN
	LOOP
		valor := valor_aleatorio_entre(-50, 50);
		RAISE NOTICE 'valor atual: %', valor;
		IF valor > 0 THEN
			contador := contador + 1;
		END IF;
		varLoop := varLoop + 1;
		EXIT WHEN varLoop >= 6;
	END LOOP;
	RAISE NOTICE 'total de números positivos: %', contador;
END;
$$

-- WHILE

DO
$$
DECLARE
	contador INT := 0;
	valor INT;
	varLoop INT = 0;
BEGIN
	WHILE varLoop < 6 LOOP
		valor := valor_aleatorio_entre(-50, 50);
		RAISE NOTICE 'valor atual: %', valor;
		IF valor > 0 THEN
			contador := contador + 1;
		END IF;
		varLoop := varLoop + 1;
	END LOOP;
	RAISE NOTICE 'total de números positivos: %', contador;
END;
$$

-- FOR

DO
$$
DECLARE
	contador INT := 0;
	valor INT;
	varLoop INT = 0;
BEGIN
	FOR i IN 1..6 LOOP
		valor := valor_aleatorio_entre(-50, 50);
		RAISE NOTICE 'valor atual: %', valor;
		IF valor > 0 THEN
			contador := contador + 1;
		END IF;
		varLoop := varLoop + 1;
		EXIT WHEN varLoop >= 6;
	END LOOP;
	RAISE NOTICE 'total de números positivos: %', contador;
END;
$$

-- FOREACH
							
DO
$$
DECLARE
	contador INT := 0;
	valores INT[] := ARRAY[valor_aleatorio_entre(-50, 50), valor_aleatorio_entre(-50, 50), valor_aleatorio_entre(-50, 50), valor_aleatorio_entre(-50, 50), valor_aleatorio_entre(-50, 50), valor_aleatorio_entre(-50, 50)];
	valor INT;
BEGIN
	FOREACH valor IN ARRAY valores LOOP
		RAISE NOTICE 'valor atual: %', valor;
		IF valor > 0 THEN
			contador := contador + 1;
		END IF;
	END LOOP;
	RAISE NOTICE 'total de números positivos: %', contador;
END;
$$

-- 1.1/3 Leia 2 valores inteiros X e Y. A seguir, calcule e mostre a soma dos números impares entre eles.
-- Entrada: O arquivo de entrada contém dois valores inteiros.
-- Saída: O programa deve imprimir um valor inteiro. Este valor é a soma dos valores ímpares que estão entre os valores fornecidos na entrada que deverá caber em um inteiro.

-- LOOP

DO
$$
DECLARE
	contador INT := 1;
	soma INT := 0;
	x INT := valor_aleatorio_entre(20, 50);
	y INT := valor_aleatorio_entre(20, 50);
	a INT := 0;
	b INT := 0;
BEGIN
	IF x < y THEN
		a := x;
		b := y;
	ELSE
		a := y;
		b := x;
	END IF;
	
	RAISE NOTICE 'X: %', a;
	RAISE NOTICE 'Y: %', b;
		
	LOOP
		IF (a + contador) % 2 <> 0 THEN
			soma := soma + (a + contador);
			RAISE NOTICE 'soma: %', soma;
		END IF;
		contador := contador + 1;
		EXIT WHEN contador >= (b - a);
	END LOOP;
	RAISE NOTICE 'soma final: %', soma;
END;
$$

-- WHILE

DO
$$
DECLARE
	contador INT := 1;
	soma INT := 0;
	x INT := valor_aleatorio_entre(20, 50);
	y INT := valor_aleatorio_entre(20, 50);
	a INT := 0;
	b INT := 0;
BEGIN
	IF x < y THEN
		a := x;
		b := y;
	ELSE
		a := y;
		b := x;
	END IF;
	
	RAISE NOTICE 'X: %', a;
	RAISE NOTICE 'Y: %', b;
		
	WHILE contador < (b - a) LOOP
		IF (a + contador) % 2 <> 0 THEN
			soma := soma + (a + contador);
			RAISE NOTICE 'soma: %', soma;
		END IF;
		contador := contador + 1;
	END LOOP;
	RAISE NOTICE 'soma final: %', soma;
END;
$$

-- FOR

DO
$$
DECLARE
	contador INT := 1;
	soma INT := 0;
	x INT := valor_aleatorio_entre(20, 50);
	y INT := valor_aleatorio_entre(20, 50);
	a INT := 0;
	b INT := 0;
BEGIN
	IF x < y THEN
		a := x;
		b := y;
	ELSE
		a := y;
		b := x;
	END IF;
	
	RAISE NOTICE 'X: %', a;
	RAISE NOTICE 'Y: %', b;
		
	FOR contador IN 1..(b - a - 1) LOOP
        IF (a + contador) % 2 <> 0 THEN
            soma := soma + (a + contador);
            RAISE NOTICE 'soma: %', soma;
        END IF;
    END LOOP;
	RAISE NOTICE 'soma final: %', soma;
END;
$$

-- FOREACH

DO
$$
DECLARE
    soma INT := 0;
    x INT := valor_aleatorio_entre(20, 50);
    y INT := valor_aleatorio_entre(20, 50);
    a INT := 0;
    b INT := 0;
    contador INT := 1;
    numerosImpares INT[] := ARRAY[]::INT[];
	i INT;
BEGIN
    IF x < y THEN
        a := x;
        b := y;
    ELSE
        a := y;
        b := x;
    END IF;

    RAISE NOTICE 'X: %', a;
    RAISE NOTICE 'Y: %', b;

    FOR i IN a+1..b-1 LOOP
        IF i % 2 <> 0 THEN
            numerosImpares := array_append(numerosImpares, i);
        END IF;
    END LOOP;

    FOREACH i IN ARRAY numerosImpares LOOP
        soma := soma + i;
        RAISE NOTICE 'soma: %', soma;
    END LOOP;

    RAISE NOTICE 'soma final: %', soma;
END;
$$;

-- 1.1/4 Leia um conjunto não determinado de pares de valores M e N (parar quando algum dos valores for menor ou igual a zero). Para cada par lido, mostre a sequência do menor até o maior e a soma dos inteiros consecutivos entre eles (incluindo o N e M).
-- Entrada? O arquivo de entrada contém um número não determinado de valores M e N. A última linha de entrada vai conter um número nulo ou negativo.
-- Saída: Para cada dupla de valores, imprima a sequência do menor até o maior e a soma deles, conforme exemplo abaixo.

-- LOOP

DO
$$
DECLARE
	var INT := 0;
	soma INT := 0;
	m INT := valor_aleatorio_entre(1, 100);
	n INT := valor_aleatorio_entre(1, 100);
	a INT := 0;
	b INT := 0;
BEGIN
	IF m < n THEN
		a := m;
		b := n;
	ELSE
		a := n;
		b := m;
	END IF;
	
	var := a;
	
	RAISE NOTICE 'sequência: % e %', a, b;
		
	LOOP
		var := var + 1;
		soma := soma + var;
		EXIT WHEN var = b-1;
	END LOOP;
	RAISE NOTICE 'soma: %', soma;
END;
$$

-- WHILE

DO
$$
DECLARE
	var INT := 0;
	soma INT := 0;
	m INT := valor_aleatorio_entre(1, 100);
	n INT := valor_aleatorio_entre(1, 100);
	a INT := 0;
	b INT := 0;
BEGIN
	IF m < n THEN
		a := m;
		b := n;
	ELSE
		a := n;
		b := m;
	END IF;
	
	var := a;
	
	RAISE NOTICE 'sequência: % e %', a, b;
		
	WHILE var < b-1 LOOP
		var := var + 1;
		soma := soma + var;
	END LOOP;
	RAISE NOTICE 'soma: %', soma;
END;
$$

-- FOR

DO
$$
DECLARE
	var INT := 0;
	soma INT := 0;
	m INT := valor_aleatorio_entre(1, 100);
	n INT := valor_aleatorio_entre(1, 100);
	a INT := 0;
	b INT := 0;
BEGIN
	IF m < n THEN
		a := m;
		b := n;
	ELSE
		a := n;
		b := m;
	END IF;
	
	var := a;
	
	RAISE NOTICE 'sequência: % e %', a, b;
		
	FOR i IN a+1..b-1 LOOP
		var := var + 1;
		soma := soma + var;
	END LOOP;
	RAISE NOTICE 'soma: %', soma;
END;
$$

-- FOREACH

DO
$$
DECLARE
	soma INT := 0;
	m INT := valor_aleatorio_entre(1, 100);
	n INT := valor_aleatorio_entre(1, 100);
	a INT := 0;
	b INT := 0;
	numeros INT[] := ARRAY[]::INT[];
	i INT;
BEGIN
	IF m < n THEN
		a := m;
		b := n;
	ELSE
		a := n;
		b := m;
	END IF;
	
	RAISE NOTICE 'sequência: % e %', a, b;
		
    FOR i IN a+1..b-1 LOOP
		numeros := array_append(numeros, i);
    END LOOP;

    FOREACH i IN ARRAY numeros LOOP
        soma := soma + i;
        RAISE NOTICE 'soma: %', soma;
    END LOOP;
	RAISE NOTICE 'soma final: %', soma;
END;
$$

-- 1.2 Faça um programa que calcule o determinante de uma matriz quadrada de ordem 3 utilizando a regra de Sarrus (https://en.wikipedia.org/wiki/Rule_of_Sarrus)

DO
$$
DECLARE
	v1 INT[] := ARRAY[valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12)];
	v2 INT[] := ARRAY[valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12)];
	v3 INT[] := ARRAY[valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12), valor_aleatorio_entre(1, 12)];
    det INT;
	aei INT;
	bfg INT;
	cdh INT;
	ceg INT;
	bdi INT;
	afh INT;
BEGIN
	RAISE NOTICE '%, %, %', v1, v2, v3;
	aei = v1[1] * v2[2] * v3[3];
	bfg = v1[2] * v2[3] * v3[1];
	cdh = v1[3] * v2[1] * v3[2];
	ceg = v1[3] * v2[2] * v3[1];
	bdi = v1[2] * v2[1] * v3[3];
	afh = v1[1] * v2[3] * v3[2];
	det := (aei + bfg + cdh) - (ceg + bdi + afh);
	RAISE NOTICE '%, %, %, %, %, %', aei, bfg, cdh, ceg, bdi, afh;
	RAISE NOTICE 'determinante: %', det;
END;
$$;
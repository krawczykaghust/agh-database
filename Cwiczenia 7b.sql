-- 1. Napisz procedurę wypisującą do konsoli ciąg Fibonacciego. Procedura musi przyjmować jako
-- argument wejściowy liczbę n. Generowanie ciągu Fibonacciego musi zostać
-- zaimplementowane jako osobna funkcja, wywoływana przez procedurę.

CREATE OR REPLACE FUNCTION fib(n integer) 
RETURNS SETOF integer
LANGUAGE SQL
AS $$
WITH RECURSIVE calculate_rec(a, b) AS (
		SELECT
			0 AS a,
			1 AS b
    UNION ALL
        SELECT b, a + b from calculate_rec
		WHERE b < n
   )
SELECT a FROM calculate_rec;
$$;


CREATE OR REPLACE PROCEDURE display_fib(n integer)
	AS $$
	BEGIN
		INSERT INTO test.test
		VALUES(fib(n));
	END;
	$$
	LANGUAGE 'plpgsql';
	
CALL display_fib(1000);
SELECT *
FROM test.test



-- 2. Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko
-- tak, aby było napisane dużymi literami.

CREATE OR REPLACE FUNCTION upper_last_name()
	RETURNS TRIGGER as $$
	BEGIN
		new.lastname = UPPER(new.lastname);
		RETURN new;
	END
	$$
	LANGUAGE 'plpgsql'
	
	
CREATE TRIGGER upper_last_name
	BEFORE INSERT ON person.person
	FOR EACH ROW
		EXECUTE PROCEDURE upper_last_name()
		


-- 3. Przygotuj trigger ‘taxRateMonitoring’, który wyświetli komunikat o błędzie, jeżeli nastąpi
-- zmiana wartości w polu ‘TaxRate’ o więcej niż 30%.

CREATE OR REPLACE FUNCTION tax_rate_message()
	RETURNS TRIGGER as $$
	BEGIN
		IF new.taxrate > 30 THEN
			RAISE WARNING 'Invalid taxrate, got % instead of %', new.taxrate, 30;
		END IF;
	END;
	$$
	LANGUAGE 'plpgsql'


CREATE TRIGGER tax_rate_checker
	BEFORE INSERT ON sales.salestaxrate
	FOR EACH ROW
		EXECUTE PROCEDURE tax_rate_message()


SELECT *
FROM sales.salestaxrate
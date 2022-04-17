-- 1. Utwórz nową bazę danych nazywając ją firma. 


CREATE DATABASE firma;

COMMENT ON DATABASE firma IS 'Firma, dla której będzie dokonana baza danych księgowości.' 


-- 2. Dodaj schemat o nazwie ksiegowosc


CREATE SCHEMA ksiegowosc;

COMMENT ON SCHEMA ksiegowosc IS 'Schemat Księgowości w małej firmie, dla którego będzie wykonana baza danych.' 

-- 3. Dodaj cztery tabele: 
-- pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
-- godziny (id_godziny, data, liczba_godzin , id_pracownika)
-- pensja (id_pensji, stanowisko, kwota)
-- premia (id_premii, rodzaj, kwota)
-- wynagrodzenie( id_wynagrodzenia, data, id_pracownika, id_godziny, id_pensji, id_premii) 


-- pracownicy (id_pracownika, imie, nazwisko, adres, telefon)

	CREATE TABLE ksiegowosc.Pracownicy
	(
		id_pracownika INT PRIMARY KEY,
		imie VARCHAR(80) NOT NULL,
		nazwisko VARCHAR(80) NOT NULL,
		adres VARCHAR(80) NOT NULL,
		telefon VARCHAR(15) NULL
	);
	
	COMMENT ON TABLE ksiegowosc.Pracownicy IS 'Tabela Pracownicy w Schemacie Ksiegowosc przedstawiająca osoby pracujące w dziale księgowości.';
	COMMENT ON COLUMN ksiegowosc.Pracownicy.id_pracownika IS 'Kolumna służąca jako klucz główny tabeli.';
	COMMENT ON COLUMN ksiegowosc.Pracownicy.imie IS 'Kolumna służąca jako do przechowywania imienia pracownika, typ varchar w celu zaoszczędzenia miejsca w pamięci.';
	COMMENT ON COLUMN ksiegowosc.Pracownicy.nazwisko IS 'Kolumna służąca jako do przechowywania nazwiska pracownika, typ varchar w celu zaoszczędzenia miejsca w pamięci.';
	COMMENT ON COLUMN ksiegowosc.Pracownicy.adres IS 'Kolumna służąca jako do przechowywania adresu pracownika, typ varchar w celu zaoszczędzenia miejsca w pamięci, oraz również dowolności podania tego adresu.';
	COMMENT ON COLUMN ksiegowosc.Pracownicy.imie IS 'Kolumna służąca do przechowywania danych na temat telefonu pracownika. Może być ona wypełniona Nullami (nie każdy pracownik musi mieć telefon).';
	
	
	CREATE TABLE ksiegowosc.Godziny
	(
		id_godziny INT PRIMARY KEY,
		data DATE NOT NULL,
		liczba_godzin INT NOT NULL,
		id_pracownika INT NOT NULL
	);
	
	ALTER TABLE ksiegowosc.Godziny
	ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.Pracownicy(id_pracownika);

	
	
	COMMENT ON TABLE ksiegowosc.Godziny IS 'Tabela Godziny w Schemacie Ksiegowosc przedstawiająca liczbę godzin przepracowanych przez dane osoby w miesiącu, date wpisu, oraz połączenie kluczem obcym z tabelą Pracownicy (w celu zapisywania jaki pracownik odbył daną ilość godzin).';
	COMMENT ON COLUMN ksiegowosc.Godziny.id_godziny IS 'Kolumna służąca jako klucz główny tabeli.';
	COMMENT ON COLUMN ksiegowosc.Godziny.data IS 'Kolumna służąca jako do przechowywania informacji na temat daty wpisania liczby godzin przepracowanych przez pracownika';
	COMMENT ON COLUMN ksiegowosc.Godziny.liczba_godzin IS 'Kolumna służąca do przechowywania informacji na temat liczby godzin przepracowanych przez pracownika w miesiącu.';
	COMMENT ON COLUMN ksiegowosc.Godziny.id_pracownika IS 'Kolumna służąca jako klucz obcy (łącznikowy) do tabeli Pracownicy, w celu zapisywania jaki pracownik odbył daną ilość godzin.';
	
	
	
	
	CREATE TABLE ksiegowosc.Pensja
	(
		id_pensji INT PRIMARY KEY,
		stanowisko VARCHAR(80) NOT NULL,
		kwota MONEY NOT NULL
	);
	
	COMMENT ON TABLE ksiegowosc.Pensja IS 'Tabela Pensja przedstawia informację na temat stanowiska danego pracownika i jego pensji miesięcznej.';
	COMMENT ON COLUMN ksiegowosc.Pensja.id_pensji IS 'Kolumna służąca jako klucz główny tabeli.';
	COMMENT ON COLUMN ksiegowosc.Pensja.stanowisko IS 'Kolumna służąca jako do przechowywania informacji na aktualnie obejmowanego stanowiska przez pracownika.';
	COMMENT ON COLUMN ksiegowosc.Pensja.kwota IS 'Kolumna służąca do przechowywania informacji na temat wynagrodzenia miesięcznego pracownika o danym stanowisku.';
	
	
	CREATE TABLE ksiegowosc.Premia
	(
		id_premii INT PRIMARY KEY,
		rodzaj VARCHAR(80) NULL,
		kwota MONEY NULL
	);


	COMMENT ON TABLE ksiegowosc.Premia IS 'Tabela Premia przedstawia informację na temat typu premii, przyznaje danemu pracownikowi, o danej kwocie.';
	COMMENT ON COLUMN ksiegowosc.Premia.id_premii IS 'Kolumna służąca jako klucz główny tabeli.';
	COMMENT ON COLUMN ksiegowosc.Premia.rodzaj IS 'Kolumna służąca jako do przechowywania informacji na temat rodzaju przyznaje premii. Jest ona kolumną NULL, ponieważ pracownik może a nie musi dostać premii.';
	COMMENT ON COLUMN ksiegowosc.Premia.kwota IS 'Kolumna służąca do przechowywania informacji na temat kwoty związanej z premią. Jest ona kolumną NULL, ponieważ pracownik może a nie musi dostać premii.';
	



	CREATE TABLE ksiegowosc.Wynagrodzenie
	(
		id_wynagrodzenia INT PRIMARY KEY,
		data DATE NOT NULL,
		id_pracownika INT NOT NULL,
		id_godziny INT NOT NULL,
		id_pensji INT NOT NULL,
		id_premii INT NOT NULL
	);
	
	
	ALTER TABLE ksiegowosc.Wynagrodzenie
		ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.Pracownicy(id_pracownika),
		ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.Godziny(id_godziny),
		ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.Pensja(id_pensji),
		ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.Premia(id_premii);
		
	
	
	
	COMMENT ON TABLE ksiegowosc.Wynagrodzenie IS 'Tabela Wynagrodzenia to tabela łącznikowa zawierająca informację na temat wynagrodzenia wydanemu pracownikowi o danej dacie z uwzględnieniem, godzin, premii i pensji.';
	COMMENT ON COLUMN ksiegowosc.Wynagrodzenie.id_wynagrodzenia IS 'Kolumna służąca jako klucz główny tabeli.';
	COMMENT ON COLUMN ksiegowosc.Wynagrodzenie.data IS 'Kolumna służąca jako do przechowywania informacji na temat daty wydania wynagrodzenia pracownikowi.';
	COMMENT ON COLUMN ksiegowosc.Wynagrodzenie.id_pracownika IS 'Kolumna służąca jako klucz obcy (łącznikowy) z tabelą pracownicy, aby wiedzieć dla jakiego pracownika zostanie ta premia wydana.';
	COMMENT ON COLUMN ksiegowosc.Wynagrodzenie.id_godziny IS 'Kolumna służąca jako klucz obcy (łącznikowy) z tabelą pracownicy, aby wiedzieć informację na temat godzin przepracowanych przez pracownika w związku z wydawanym wynagrodzeniem.';
	COMMENT ON COLUMN ksiegowosc.Wynagrodzenie.id_pensji IS 'Kolumna służąca jako klucz obcy (łącznikowy) z tabelą pracownicy, aby wiedzieć wartość podstawowej pensji pracownika.';
	COMMENT ON COLUMN ksiegowosc.Wynagrodzenie.id_premii IS 'Kolumna służąca jako klucz obcy (łącznikowy) z tabelą pracownicy, aby wiedzieć wartość premii dla pracownika.';
	
	-- 4. Wypełnij każdą tabelę 10. rekordami.
	
	
	INSERT INTO ksiegowosc.Pracownicy VALUES
	('0', 'Aleksandra', 'Nowak', 'ul.Kwiatowa 2, 32-043, Krakow', '721 543 621'),
	('1', 'Leon', 'Kowalski', 'ul.Basztowa 14, 31-026, Krakow', '711 513 611'),
	('2', 'Magdalena', 'Bury', 'ul.Oliwkowa 1, 32-013, Krakow', NULL),
	('3', 'Weronika', 'Kowal', 'ul.Jagodowa 54, 31-021, Krakow', '631 543 644'),
	('4', 'Tomasz', 'Kamiński', 'ul.Włoska 16, 30-043, Krakow', '766 123 111'),
	('5', 'Paweł', 'Wiśniewski', 'ul.Laurowa 16, 30-023, Krakow', NULL),
	('6', 'Anna', 'Lewandowska', 'ul.Akacjowa 5, 35-143, Krakow', '722 113 142'),
	('7', 'Karolina', 'Kowalczyk', 'ul.Warszawska 11, 31-021, Krakow', '546 133 311'),
	('8', 'Michał', 'Brzoza', 'ul.Wierzbowa 23, 33-123, Krakow', '726 323 431'),
	('9', 'Iwona', 'Szymańska', 'ul.Włoska 16, 30-043, Krakow', '656 423 5421');
	
	INSERT INTO ksiegowosc.Godziny VALUES
	('0', '2022-03-12', '150', '0'),
	('1', '2022-03-12', '200', '1'),	
	('2', '2022-03-13', '160', '2'),
	('3', '2022-03-13', '100', '3'),
	('4', '2022-03-14', '120', '4'),
	('5', '2022-03-14', '130', '5'),
	('6', '2022-03-14', '100', '6'),
	('7', '2022-03-15', '50', '7'),
	('8', '2022-03-15', '220', '8'),
	('9', '2022-03-16', '124', '9');
	
	
	
	INSERT INTO ksiegowosc.Pensja VALUES
	('0', 'Programista', '14000'),
	('1', 'Admiinistrator', '10000'),
	('2', 'Programista', '8000'),
	('3', 'Admiinistrator', '30000'),
	('4', 'Admiinistrator', '9500'),
	('5', 'Analityk', '17000'),
	('6', 'Analityk', '25000'),
	('7', 'Programista', '17000'),
	('8', 'Analityk', '15000'),
	('9', 'Analityk', '2000');
	
	
	INSERT INTO ksiegowosc.Premia VALUES
	('0', 'Zadaniowa', '500'),
	('1', 'Motywacyjna', '100'),
	('2', 'Zadaniowa', '500'),
	('3', 'Uznaniowa', NULL),
	('4', 'Motywacyjna', '100'),
	('5', 'Wynikowa', '1000'),
	('6', 'Zadaniowa', NULL),
	('7', 'Wynikowa', '1500'),
	('8', 'Wynikowa', '1000'),
	('9', 'Uznaniowa', '200');
	
	
	
	INSERT INTO ksiegowosc.Wynagrodzenie VALUES
	('0', '2022-03-09', '0', '0', '0', '0'),
	('1', '2022-03-10', '1', '1', '1', '1'),
	('2', '2022-03-10', '2', '2', '2', '2'),
	('3', '2022-03-11', '3', '3', '3', '3'),
	('4', '2022-03-11', '4', '4', '4', '4'),
	('5', '2022-03-12', '5', '5', '5', '5'),
	('6', '2022-03-12', '6', '6', '6', '6'),
	('7', '2022-03-13', '7', '7', '7', '7'),
	('8', '2022-03-13', '8', '8', '8', '8'),
	('9', '2022-03-13', '9', '9', '9', '9');



-- a) Wyświetl tylko id pracownika oraz jego nazwisko.

SELECT ksiegowosc.Pracownicy.id_pracownika, ksiegowosc.Pracownicy.imie
FROM ksiegowosc.Pracownicy

-- b) Wyświetl id pracowników, których płaca jest większa niż 1000.


SELECT p1.id_pracownika
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
WHERE p2.kwota > cast(20000 AS money)



-- c) Wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000. 


SELECT p1.id_pracownika
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
INNER JOIN ksiegowosc.Premia AS p3
ON w.id_premii = p3.id_premii
WHERE p2.kwota > cast(20000 AS money) AND p3.kwota IS NULL


-- d) Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’. 

SELECT ksiegowosc.Pracownicy.id_pracownika, ksiegowosc.Pracownicy.imie, ksiegowosc.Pracownicy.nazwisko
FROM ksiegowosc.Pracownicy
WHERE ksiegowosc.Pracownicy.imie LIKE 'L%'


-- e) Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’.
	
SELECT ksiegowosc.Pracownicy.id_pracownika, ksiegowosc.Pracownicy.imie, ksiegowosc.Pracownicy.nazwisko
FROM ksiegowosc.Pracownicy
WHERE ksiegowosc.Pracownicy.nazwisko LIKE '%n%a'


-- f) Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, iż standardowy czas pracy to 160 h miesięcznie. 

SELECT p1.imie, p1.nazwisko, g.liczba_godzin,
CASE
	WHEN (g.liczba_godzin > 160) THEN liczba_godzin-160
END AS nadgodziny
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika	
INNER JOIN ksiegowosc.Godziny AS g
ON w.id_godziny = g.id_godziny


-- ALTER TABLE ksiegowosc.godziny ADD liczba_nadgodzin INT;
-- UPDATE ksiegowosc.godziny SET liczba_nadgodzin = liczba_godzin-160
-- WHERE ksiegowosc.godziny.liczba_godzin > 160;



-- g)  Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000 PLN.


SELECT p1.imie, p1.nazwisko
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
WHERE p2.kwota BETWEEN cast(1500 AS money) AND cast(3000 AS money)

-- h) Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii.

--POPRAWIC

SELECT p1.imie, p1.nazwisko, g.liczba_godzin,
CASE
	WHEN (g.liczba_godzin > 160) THEN liczba_godzin-160
END AS nadgodziny
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika	
INNER JOIN ksiegowosc.Godziny AS g
ON w.id_godziny = g.id_godziny
INNER JOIN ksiegowosc.Premia AS p3
ON w.id_premii = p3.id_premii
WHERE (g.liczba_godzin > 160) AND p3.kwota IS NULL


-- i) Uszereguj pracowników według pensji.

SELECT p1.imie, p1.nazwisko, p2.kwota
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
ORDER BY p2.kwota


-- j) Uszereguj pracowników według pensji i premii malejąco.

SELECT p1.imie, p1.nazwisko, p2.kwota AS pensja, p3.kwota AS premia
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
INNER JOIN ksiegowosc.Premia AS p3
ON w.id_premii = p3.id_premii
ORDER BY p2.kwota, p3.kwota DESC



-- k) Zlicz i pogrupuj pracowników według pola ‘stanowisko’.

SELECT 
	p2.stanowisko,
	COUNT(p2.stanowisko)
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
GROUP BY p2.stanowisko



-- l) Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’ (jeżeli takiego nie masz, to przyjmij dowolne inne).

SELECT 
	p2.stanowisko,
	AVG(p2.kwota::numeric) AS srednia_placa,
	MIN(p2.kwota) AS minimalna_placa,
	MAX(p2.kwota) AS maksymalna_placa
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
GROUP BY p2.stanowisko


-- m) Policz sumę wszystkich wynagrodzeń.


SELECT 
	SUM(p2.kwota) AS suma_wynagrodzen
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji


-- j) Policz sumę wynagrodzeń w ramach danego stanowiska.


SELECT 
	p2.stanowisko,
	SUM(p2.kwota) AS suma_wynagrodzen
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
GROUP BY p2.stanowisko

-- g) Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska

SELECT 
	p2.stanowisko,
	COUNT(p3.id_premii) AS liczba_premii,
	SUM(p2.kwota) AS suma_wynagrodzen
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
INNER JOIN ksiegowosc.Premia AS p3	
ON w.id_premii = p3.id_premii
GROUP BY p2.stanowisko


-- i) Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł.

--DELETE POPRAWIC


DELETE 
FROM ksiegowosc.Pracownicy AS p1
USING ksiegowosc.Wynagrodzenie AS w, ksiegowosc.Pensja AS p2
WHERE 
	p1.id_pracownika = w.id_pracownika AND
	w.id_pensji = p2.id_pensji AND
	p2.kwota < cast(1500 AS money);


-- Test Select

SELECT *
FROM ksiegowosc.Pracownicy
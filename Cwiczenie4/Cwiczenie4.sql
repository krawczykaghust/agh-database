USE firma;
GO


--1. Tworzenie bazy danych o nazwie firma

CREATE DATABASE firma;

--2. Tworzenie schematu o nazwie rozliczenia (zak³adka Security)

GO

CREATE SCHEMA rozliczenia;

GO
--3. Dodanie do schematu 'rozliczenia' cztery tabele

	-- pracownicy(id_pracownika, imie, nazwisko, adres, telefon) 

CREATE TABLE rozliczenia.pracownicy(
	
	id_pracownika CHAR(6) PRIMARY KEY,
	imie VARCHAR(80) NOT NULL,
	nazwisko VARCHAR(80) NOT NULL,
	adres VARCHAR(50) NOT NULL,
	telefon CHAR(12) NULL,
);


	-- godziny(id_godziny, data, liczba_godzin , id_pracownika) 


CREATE TABLE rozliczenia.godziny(
	
	id_godziny CHAR(6) PRIMARY KEY,
	data DATE NOT NULL,
	liczba_godzin SMALLINT NOT NULL,
	id_pracownika CHAR(6) NOT NULL
);


	-- pensje(id_pensji, stanowisko, kwota, id_premii) 

CREATE TABLE rozliczenia.pensje(
	
	id_pensji CHAR(6) PRIMARY KEY,
	stanowisko VARCHAR(80) NOT NULL,
	kwota SMALLMONEY NOT NULL,
	id_premii CHAR(6) NULL
);





	-- premie(id_premii, rodzaj, kwota) 


CREATE TABLE rozliczenia.premie(
	
	id_premii CHAR(6) PRIMARY KEY,
	rodzaj VARCHAR(80) NULL,
	kwota SMALLMONEY NULL,
);

-- d) Zastanów siê jakie zwi¹zki zachodz¹ pomiêdzy tabelami, a nastêpnie dodaj klucze obce
-- tam, gdzie wystêpuj¹ (wykorzystaj polecenie ALTER TABLE – po uprzednim stworzeniu
-- tabeli).

-- Relacja Pracownicy - Godziny 1:N (Kazdy pracownik moze wyrobic jedna lub wiecej godzin ale jedna godzina moze
-- byæ wyrobiona przez jednego pracownika)

--Dodanie za pomoca ALTER TABLE (modyfikuje schemat realcji) klucza obcego
ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);



-- Relacja Pesnje - Premie 1:N (Ka¿da pensja mo¿e mieæ dodan¹ jedn¹ lub wiêcej premie, ale jedna premia mo¿e byæ dodan do tylko jednej
-- pensji.)

--Dodanie za pomoca ALTER TABLE (modyfikuje schemat realcji) klucza obcego
ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie(id_premii);



--4. Wype³nij ka¿d¹ tabelê 10. rekordami

-- Pracownicy

INSERT INTO rozliczenia.pracownicy
(
	[id_pracownika],
	[imie],
	[nazwisko],
	[adres],
	[telefon]
)
VALUES
(
	1,
	'Adam',
	'Koj',
	'Kraków al.Mickiewicza 15 31-867',
	'543897643'
)
,(
	2,
	'Ewa',
	'Koc',
	'Bochnia ul.Zwierzyniecka 5 32-890',
	'512432132'
)
,(
	3,
	'Stefan',
	'Maj',
	'Warszawa ul.Maki 22/34 22-005',
	NULL
)
,(
	4,
	'Mateusz',
	'Kowalski',
	'Wieliczka ul.Dobczycka 78/1 32-768',
	NULL
)
,(
	5,
	'Katarzyna',
	'Nowak',
	'Niepo³omice ul.D¹browskiej 80 33-657',
	'452897123'
)
,(
	6,
	'Jan',
	'Adamczyk',
	'Kraków ul.Prosta 65/45 30-059',
	NULL
)
,(
	7,
	'Filip',
	'Las',
	'Lublin ul.Zak¹tek 3/49 70-388',
	6789676523
)
,(
	8,
	'Natalia',
	'Drabek',
	'Kraków ul.Krótka 56 31-098',
	NULL
)
,(
	9,
	'Wojciech',
	'Maj',
	'£ódŸ ul.D¹browskiej 3a 90-001',
	NULL
)
,(
	10,
	'Weronika',
	'Kula',
	'Katowice ul.Magnoliowa 1b 35-890',
	NULL
)


SELECT * FROM rozliczenia.pracownicy


-- Premie

INSERT INTO rozliczenia.premie
(
	[id_premii],
	[rodzaj],
	[kwota]
)
VALUES
(
	1,
	NULL,
	NULL
)
,(
	2,
	'Uznaniowa',
	1000
)
,(
	3,
	'Uznaniowa',
	700
)
,(
	4,
	'Regulaminowa',
	650
)
,(
	5,
	NULL,
	NULL
)
,(
	6,
	NULL,
	NULL
)
,(
	7,
	'Uznaniowa',
	1500
)
,(
	8,
	'Uznaniowa',
	2000
)
,(
	9,
	NULL,
	NULL
)
,(
	10,
	'Regulaminowa',
	450
)


SELECT * FROM rozliczenia.premie


--Pensje


INSERT INTO rozliczenia.pensje
(
	[id_pensji],
	[stanowisko],
	[kwota],
	[id_premii]
)
VALUES
(
	1,
	'Programista',
	8500,
	1
)
,(
	2,
	'Analityk',
	10500,
	2
)
,(
	3,
	'Analityk',
	9700,
	3
)
,(
	4,
	'Programista',
	8650,
	4
)
,(
	5,
	'Sta¿ysta',
	3300,
	5
)
,(
	6,
	'Sta¿ysta',
	450,
	6
)
,(
	7,
	'Analityk',
	11500,
	7
)
,(
	8,
	'Administrator',
	14000,
	8
)
,(
	9,
	'Sta¿ysta',
	3350,
	9
)
,(
	10,
	'Administrator',
	14450,
	10

)


SELECT * FROM rozliczenia.pensje


-- Godziny



INSERT INTO rozliczenia.godziny
(
	[id_godziny],
	[data], --DATE - format YYYY-MM-DD
	[liczba_godzin],
	[id_pracownika]
)
VALUES
(
	1,
	'2022-03-01',
	150,
	1
)
,(
	2,
	'2022-03-02',
	200,
	2
)
,(
	3,
	'2022-03-03',
	180,
	3
)
,(
	4,
	'2022-03-03',
	165,
	4
)
,(
	5,
	'2022-03-04',
	80,
	5
)
,(
	6,
	'2022-03-05',
	80,
	6
)
,(
	7,
	'2022-03-05',
	300,
	7
)
,(
	8,
	'2022-03-05',
	300,
	8
)
,(
	9,
	'2022-03-06',
	100,
	9
)
,(
	10,
	'2022-03-07',
	350,
	10

)


SELECT * FROM rozliczenia.godziny


-- 5. Za pomoc¹ zapytania SQL wyœwietl nazwiska pracowników i ich adresy

SELECT pracownicy.nazwisko, pracownicy.adres FROM rozliczenia.pracownicy


-- 6. Napisz zapytanie, które przekonwertuje datê w tabeli godziny tak, aby wyœwietlana by³a
-- informacja jaki to dzieñ tygodnia i jaki miesi¹c (funkcja DATEPART x2).

SELECT DATEPART(ww, godziny.data) [week],
	DATEPART(month, godziny.data) [month]
FROM rozliczenia.godziny

--Pogladowo

SELECT 
	godziny.data,
	DATEPART(ww, godziny.data) [week],
	DATEPART(month, godziny.data) [month]
FROM rozliczenia.godziny



-- 7. W tabeli pensje zmieñ nazwê atrybutu kwota na kwota_brutto oraz dodaj nowy o nazwie
-- kwota_netto. Oblicz kwotê netto i zaktualizuj wartoœci w tabeli.

EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto';




ALTER TABLE rozliczenia.pensje 
	ADD kwota_netto AS (pensje.kwota_brutto*1.19)



SELECT * FROM rozliczenia.pensje
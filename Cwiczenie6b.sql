-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodając do niego kierunkowy dla Polski w nawiasie (+48)

-- Uzywamy znaku concatenation (||), ktory pozwala na zlaczenie ze soba dwoch stringow przy okazji omijajac null values

UPDATE ksiegowosc.Pracownicy
SET
	telefon = '+48'||telefon
	
	
SELECT *
FROM ksiegowosc.Pracownicy
	


-- b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony był myślnikami wg wzoru: ‘555-222-333’ 


-- Uzywamy metody SUBSTRING, ktora pozwala na otrzymanie danego zestawu znaków ze stringa, a nastepnie uzywamy znaku concatenation ||, aby poprawnie polaczyc numer

UPDATE ksiegowosc.Pracownicy
SET
	telefon = '' || SUBSTRING(telefon FROM 1 FOR 3) || ' ' || SUBSTRING(telefon FROM 4 FOR 3) || '-'  || SUBSTRING(telefon FROM 7 FOR 3) || '-'  || SUBSTRING(telefon FROM 10 FOR 3)


SELECT *
FROM ksiegowosc.Pracownicy


-- c) Wyświetl dane pracownika, którego nazwisko jest najdłuższe, używając dużych liter


 -- Sposob z sortowaniem
 
SELECT
	p1.id_pracownika,
	UPPER(p1.imie) as imie,
	UPPER(p1.nazwisko) as nazwisko,
	UPPER(p1.adres) as adres,
	p1.telefon,
	LENGTH(p1.nazwisko) as len
FROM ksiegowosc.Pracownicy as p1
ORDER BY len DESC
LIMIT 1;

-- Sposob z funkcja agregujaca

SELECT 
	p1.id_pracownika,
	UPPER(p1.imie) as imie,
	UPPER(p1.nazwisko) as nazwisko,
	UPPER(p1.adres) as adres,
	p1.telefon
FROM ksiegowosc.Pracownicy as p1
WHERE LENGTH(p1.nazwisko) = (
	SELECT MAX(LENGTH(p1.nazwisko))
	FROM ksiegowosc.Pracownicy as p1);


-- d) Wyświetl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5 

SELECT *
FROM ksiegowosc.Pensja

SELECT 
	p1.id_pracownika,
	MD5(p1.imie) as imie,
	MD5(p1.nazwisko) as nazwisko,
	MD5(p1.adres) as adres,
	MD5(p1.telefon) as telefon,
	MD5(p2.kwota::char) as pensja
FROM ksiegowosc.Pracownicy as p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji

-- e) Wyświetl pracowników, ich pensje oraz premie. Wykorzystaj złączenie lewostronne

-- (INNER) JOIN: Returns records that have matching values in both tables
-- LEFT (OUTER) JOIN: Returns all records from the left table, and the matched records from the right table
-- RIGHT (OUTER) JOIN: Returns all records from the right table, and the matched records from the left table
-- FULL (OUTER) JOIN: Returns all records when there is a match in either left or right table


-- Select All

SELECT *
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
INNER JOIN ksiegowosc.Premia AS p3
ON w.id_premii = p3.id_premii


SELECT *
FROM ksiegowosc.Pracownicy AS p1
LEFT OUTER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
LEFT OUTER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
LEFT OUTER JOIN ksiegowosc.Premia AS p3
ON w.id_premii = p3.id_premii

-- Wybrane Dane


SELECT 
	p1.id_pracownika,
	p1.imie,
	p1.nazwisko,
	p2.kwota as pensja,
	p3.kwota as premia
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
INNER JOIN ksiegowosc.Premia AS p3
ON w.id_premii = p3.id_premii


SELECT 
	p1.id_pracownika,
	p1.imie,
	p1.nazwisko,
	p2.kwota as pensja,
	p3.kwota as premia
FROM ksiegowosc.Pracownicy AS p1
LEFT OUTER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
LEFT OUTER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
LEFT OUTER JOIN ksiegowosc.Premia AS p3
ON w.id_premii = p3.id_premii

-- g) Wygeneruj raport (zapytanie), które zwróci w wyniki treść wg poniższego szablonu:


SELECT 
	'Pracownik ' || p1.imie || ' ' || p1.nazwisko || ', w dniu ' || w.data || ' otrzymał pensję całkowitą na kwotę ' || (p2.kwota+p3.kwota) || ' , gdzie wynagrodzenie zasadnicze wynosiło: ' || p2.kwota  || ', premia: ' || p3.kwota || ', nadgodziny: ' ||   (g.liczba_nadgodzin * 12)  ||'zł.'  AS raport 
FROM ksiegowosc.Pracownicy AS p1
INNER JOIN ksiegowosc.Wynagrodzenie AS w
ON p1.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.Pensja AS p2
ON w.id_pensji = p2.id_pensji
INNER JOIN ksiegowosc.Premia AS p3
ON w.id_premii = p3.id_premii
INNER JOIN ksiegowosc.Godziny AS g
ON w.id_godziny = g.id_godziny






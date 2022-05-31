-- 1. Wykorzystując wyrażenie CTE zbuduj zapytanie, które znajdzie informacje na temat stawki
-- pracownika oraz jego danych, a następnie zapisze je do tabeli tymczasowej
-- TempEmployeeInfo. Rozwiąż w oparciu o AdventureWorks.

USE AdventureWorks2019;

-- Human Resources - Employee Pay Hstory Stawka, Employee Dane, Schemat Person


CREATE TABLE HumanResources.EmployeeInfo
(
	Name nvarchar(50),
	LastName nvarchar(50),
	Salary  money,
	Title nvarchar(50),
	Gender nchar(1),
	HireDate DATE
);

SELECT *
FROM HumanResources.EmployeeInfo;


WITH PERSON_INFO (BusinessEntityID, Name, Lastname)
AS
(
	SELECT
		p.BusinessEntityID,
		p.FirstName AS Name,
		p.LastName AS Lastname
	FROM Person.Person AS p
),
EMPLOYEE_INFO (BusinessEntityID, Title, Gender, HireDate)
AS
(
	SELECT
		emp.BusinessEntityID,
		emp.JobTitle AS Title,
		emp.Gender,
		emp.HireDate
	FROM HumanResources.Employee AS emp
),
EMPLOYEE_PAYMENT_INFO (BusinessEntityID, Salary)
AS
(
	SELECT 
		pa.BusinessEntityID,
		pa.Rate as Salary
	FROM HumanResources.EmployeePayHistory as pa
		
)
INSERT INTO HumanResources.EmployeeInfo (Name, Lastname, Salary, Title, Gender, HireDate)
SELECT Name, Lastname, Salary, Title, Gender, HireDate
FROM PERSON_INFO
JOIN EMPLOYEE_INFO ON PERSON_INFO.BusinessEntityID = EMPLOYEE_INFO.BusinessEntityID
JOIN EMPLOYEE_PAYMENT_INFO ON PERSON_INFO.BusinessEntityID = EMPLOYEE_PAYMENT_INFO.BusinessEntityID

SELECT *
FROM HumanResources.EmployeeInfo;


-- 2. Uzyskaj informacje na temat przychodów ze sprzedaży według firmy i kontaktu (za pomocą
-- CTE i bazy AdventureWorksL). Wynik powinien wyglądać następująco:

USE AdventureWorksLT2019;


WITH COMPANY_CONTACT (CompanyContact, CustomerID)  
AS  
(  
    SELECT 
		Customer.CompanyName + ' (' + FirstName + ' ' + LastName + ')' AS CompanyContact,
		Customer.CustomerID
    FROM SalesLT.Customer AS Customer
),
COMPANY_REVENUE (Revenue, CustomerID)
AS
(
	SELECT
		SalesOrderHeader.TotalDue AS Revenue,
		SalesOrderHeader.CustomerID
	FROM SalesLT.SalesOrderHeader AS SalesOrderHeader
)
SELECT CompanyContact, Revenue
FROM COMPANY_CONTACT  
JOIN COMPANY_REVENUE ON COMPANY_CONTACT.CustomerID = COMPANY_REVENUE.CustomerID
ORDER BY CompanyContact



-- 3. Napisz zapytanie, które zwróci wartość sprzedaży dla poszczególnych kategorii produktów.
-- Wykorzystaj CTE i bazę AdventureWorksLT.

WITH PRODUCT (ProductCategoryID, ProductID)
AS
(
	SELECT
		Product.ProductCategoryID,
		Product.ProductID
	FROM SalesLT.Product as Product
),
PRODUCT_CATEGORY (ProductCategoryID, Category)
AS 
(
	SELECT
		ProductCategory.ProductCategoryID,
		ProductCategory.Name
	FROM SalesLT.ProductCategory as ProductCategory
),
SALES_ORDER_DETAIL_CTE (ProductID, SalesValue)
AS
(
	SELECT
		SalesOrderDetail.ProductID,
		SalesOrderDetail.LineTotal
	FROM SalesLT.SalesOrderDetail AS SalesOrderDetail
)
SELECT 
	Category, 
	SUM(SalesValue) AS SalesValue
FROM PRODUCT_CATEGORY
JOIN PRODUCT ON PRODUCT_CATEGORY.ProductCategoryID = PRODUCT.ProductCategoryID
JOIN SALES_ORDER_DETAIL_CTE ON PRODUCT.ProductID = SALES_ORDER_DETAIL_CTE.ProductID
GROUP BY Category






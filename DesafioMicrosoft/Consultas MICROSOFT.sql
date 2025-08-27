-- Desafio Consultas MICROSOFT

-- 1. Criar um relat�rio que mostre os detalhes principais dos produtos, combinando informa��es de produtos, categorias e fornecedores.
-- Listar o nome do produto, o nome da empresa fornecedora, o nome da categoria, o pre�o unit�rio do produto e a quantidade em estoque.

SELECT 
    p.ProductName, 
    s.CompanyName AS Supplier, 
    c.CategoryName AS Category, 
    p.UnitPrice, 
    p.UnitsInStock
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID;


-- 2.Filtrar a lista de produtos, mostrando apenas aqueles que est�o dispon�veis para venda imediata. 
-- A partir da consulta anterior, ocultar os produtos que possuem estoque zerado ou que foram descontinuados.

SELECT 
    p.ProductName,
    s.CompanyName,
    c.CategoryName,
    p.UnitPrice,
    p.UnitsInStock
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE p.UnitsInStock > 0
  AND p.Discontinued = 0
ORDER BY p.ProductName;


-- 3. Analisar a produtividade da equipe de vendas, contando o n�mero total de pedidos (vendas) por vendedor.
--Mostrar o nome completo de cada vendedor (funcion�rio) e a quantidade total de vendas que ele realizou.

SELECT 
    e.FirstName, 
    e.LastName, 
    COUNT(o.OrderID) AS TotalVendas
FROM Employees e
JOIN Orders o
    ON e.EmployeeID = o.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY TotalVendas DESC;


-- Identificar os vendedores com o maior volume de transa��es. 
-- Utilizando a mesma l�gica da consulta anterior, exibir apenas os vendedores que realizaram uma quantidade de vendas maior ou igual a 100.
SELECT FirstName, LastName, TotalVendas
FROM (
    SELECT e.FirstName, e.LastName, COUNT(o.OrderID) AS TotalVendas
    FROM Employees e
    JOIN Orders o ON e.EmployeeID = o.EmployeeID
    GROUP BY e.FirstName, e.LastName
) AS Sub
WHERE TotalVendas >= 100;


-- 5. Entender a distribui��o de trabalho dos vendedores por �reas geogr�ficas.
-- Mostrar o nome completo do vendedor e a quantidade de territ�rios aos quais ele est� vinculado.

SELECT 
    e.FirstName, 
    e.LastName, 
    COUNT(et.TerritoryID) AS TotalTerritorios
FROM Employees e
JOIN EmployeeTerritories et
    ON e.EmployeeID = et.EmployeeID
GROUP BY e.FirstName, e.LastName
ORDER BY TotalTerritorios DESC;

-- 6. Classificar os pedidos pelo seu valor monet�rio total, permitindo identificar as vendas mais valiosas. Listar todos os pedidos, 
-- calculando o valor total de cada um (considerando pre�o, quantidade e desconto) e orden�-los do maior para o menor valor.

SELECT OD.OrderID,
       SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS ValorTotal
FROM [Order Details] AS OD
GROUP BY OD.OrderID
ORDER BY ValorTotal DESC;



-- 7. Crie uma consulta que identifique todos os itens de pedidos que foram vendidos por um pre�o unit�rio 
-- inferior ao padr�o cadastrado na tabela de produtos. 
-- Exiba o ID do Pedido, o nome do produto, o pre�o de lista e o pre�o que foi efetivamente

SELECT 
    od.OrderID,
    p.ProductName,
    p.UnitPrice AS PrecoLista,
    od.UnitPrice AS PrecoVendido
FROM "Order Details" od
JOIN Products p ON od.ProductID = p.ProductID
WHERE od.UnitPrice < p.UnitPrice
ORDER BY od.OrderID;

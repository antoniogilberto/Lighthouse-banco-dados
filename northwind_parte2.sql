-- Qual foi o melhor mês de vendas da Northwind?

SELECT to_char(order_date, 'YYYY-MM') AS AnoMes, SUM(Quantity*od.unit_price*(1-Discount)) AS total
FROM orders o INNER JOIN order_details od 
ON o.order_id = od.order_id
GROUP BY AnoMes
ORDER BY total DESC;

-- Outra forma de resolução 

SELECT to_char(order_date, 'MM') AS Mes, SUM(Quantity*od.unit_price*(1-Discount)) AS total
FROM orders o INNER JOIN order_details od 
ON o.order_id = od.order_id
GROUP BY Mes
ORDER BY total DESC;

--    Qual o total de vendas dos 5 maiores clientes do Brasil?

SELECT c.customer_id, c.company_name, SUM(od.unit_price * od.quantity) AS total_vendas
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
WHERE c.country = 'Brazil'
GROUP BY c.customer_id, c.company_name
ORDER BY total_vendas DESC
LIMIT 5;



-- Qual supplier com mais vendas para o Brasil?
SELECT s.supplier_id, s.company_name, SUM(od.quantity) AS total_vendas
FROM suppliers s
INNER JOIN products p ON s.supplier_id = p.supplier_id
INNER JOIN order_details od ON p.product_id = od.product_id
INNER JOIN orders o ON od.order_id = o.order_id
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.country = 'Brazil'
GROUP BY s.supplier_id, s.company_name
ORDER BY total_vendas DESC
LIMIT 1;



--Qual vendedor (employee) realizou mais vendas para clientes com customer.postal_code do Brasil?
SELECT e.employee_id, e.first_name, e.last_name, COUNT(o.order_id) AS total_vendas
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.country = 'Brazil' AND c.postal_code LIKE '__%'
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_vendas DESC
LIMIT 1;


--    Qual employee que mais gerou resultados para a Northwind em número de pedidos?

SELECT e.employee_id, e.first_name, e.last_name, COUNT(o.order_id) AS total_pedidos
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_pedidos DESC
LIMIT 1;


--    Qual employee que mais gerou resultados para a Northwind em total de itens vendidos?
SELECT e.employee_id, e.first_name, e.last_name, SUM(od.quantity) AS total_itens_vendidos
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_itens_vendidos DESC
LIMIT 1;


--    Qual employee que mais gerou resultados para a Northwind em valor total dos pedidos
SELECT e.employee_id, e.first_name, e.last_name, SUM(od.quantity * od.unit_price) AS total_vendas
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_vendas DESC
LIMIT 1;
import psycopg2

# Altere as conexões para o seu banco de dados

params = {
    "host":"127.0.0.1",
    "database":"minha_empresa",
    "user":"postgres",
    "port":5432,
    "password":"postgres"}

def run_queries(params, commands):
    """ Runs the given query"""
    conn = None
    try:
        # connect to the PostgreSQL server
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        # Run Queries one by one
        for command in commands:
            print("Executing command: %s" % command)
            cur.execute(command)
            print("Returning result: %s" % cur.fetchall())
            print("--------------------------------")

        # close communication with the PostgreSQL database server
        cur.close()
        # commit the changes
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

# Não alterar acima desta linhas
## --------------------------------------##
## Desafio

#Qual foi o melhor mês de vendas da Northwind?

query_1 = '''SELECT to_char(order_date, 'YYYY-MM') AS Ano_Mes, SUM(Quantity*od.unit_price*(1-Discount)) AS Total
FROM orders o INNER JOIN order_details od 
ON o.order_id = od.order_id
GROUP BY Ano_Mes
ORDER BY Total DESC;
'''


#Qual o total de vendas dos 5 maiores clientes do Brasil?

query_2 = '''SELECT  c.customer_id, c.company_name, SUM(od.unit_price*od.quantity*(1 - od.discount)) AS total_vendas
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od.order_id
WHERE c.country = 'Brazil'
GROUP BY c.customer_id, c.company_name
ORDER BY total_vendas DESC
LIMIT 5; '''



#Qual supplier com mais vendas para o Brasil?

query_3 = '''SELECT s.supplier_id, s.company_name, SUM(od.quantity) AS total_sales
FROM suppliers s
LEFT JOIN products p ON s.supplier_id = p.supplier_id
LEFT JOIN order_details od ON p.product_id = od.product_id
LEFT JOIN orders o ON od.order_id = o.order_id
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.country = 'Brazil'
GROUP BY s.supplier_id, s.company_name
ORDER BY total_sales DESC
LIMIT 1;'''



#Qual vendedor (employee) realizou mais vendas para clientes com customer.postal_code do Brasil?

query_4 = '''SELECT e.employee_id, e.first_name, e.last_name, COUNT(o.order_id) AS total_vendas
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN customers c ON o.customer_id = c.customer_id
WHERE c.country = 'Brazil' AND c.postal_code LIKE '__%'
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_vendas DESC
LIMIT 1;'''



#Qual employee que mais gerou resultados para a Northwind em número de pedidos?

query_5 = '''SELECT e.employee_id, e.first_name, e.last_name, COUNT(o.order_id) AS total_pedidos
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_pedidos DESC
LIMIT 1;'''



#Qual employee que mais gerou resultados para a Northwind em total de itens vendidos?

query_6 = '''SELECT e.employee_id, e.first_name, e.last_name, SUM(od.quantity) AS total_itens_vendidos
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_itens_vendidos DESC
LIMIT 1;'''



#Qual employee que mais gerou resultados para a Northwind em valor total dos pedidos

query_7 = '''SELECT e.employee_id, e.first_name, e.last_name, SUM(od.quantity * od.unit_price) AS total_vendas
FROM employees e
INNER JOIN orders o ON e.employee_id = o.employee_id
INNER JOIN order_details od ON o.order_id = od.order_id
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY total_vendas DESC
LIMIT 1;'''


# Crie uma nova query para cada tarefa
# query_2 = """ CREATE TABLE produto..""""

# Adicione todas as queries na lista abaixo
queries = [query_1, query_2, query_3, query_4, query_5, query_6, query_7]

#----------------------------------------##
# Não alterar abaixo desta linha

if __name__ == '__main__':
    run_queries(params, queries)


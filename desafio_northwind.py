import psycopg2

# Altere as conexões para o seu banco de dados

params = {
    "host":"127.0.0.1",
    "database":"northwind",
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

query_1 = '''select to_char(order_date, 'YYYY-MM')
	as ano_mes,
	sum(Quantity*od.unit_price*(1-Discount)) as total
from orders o
inner join order_details od 
ON o.order_id = od.order_id
group by Ano_Mes
order by Total desc;
'''


#Qual o total de vendas dos 5 maiores clientes do Brasil?

query_2 = '''select 
	c.customer_id
	, c.company_name
	, sum(od.unit_price*od.quantity*(1 - od.discount)) as total_vendas
from customers c
inner join orders o on c.customer_id = o.customer_id
inner join order_details od on o.order_id = od.order_id
where
	c.country = 'Brazil'
group by c.customer_id, c.company_name
order by total_vendas desc
limit 5; '''



#Qual supplier com mais vendas para o Brasil?

query_3 = '''select
	s.supplier_id
	, s.company_name
	, SUM(od.quantity) as total_sales
from suppliers s
left join products p on s.supplier_id = p.supplier_id
left join order_details od on p.product_id = od.product_id
left join orders o on od.order_id = o.order_id
left join customers c on o.customer_id = c.customer_id
where
	c.country = 'Brazil'
group by s.supplier_id, s.company_name
order by total_sales desc
limit 1;'''



#Qual vendedor (employee) realizou mais vendas para clientes com customer.postal_code do Brasil?

query_4 = '''select
	e.employee_id
	, e.first_name	
	, e.last_name, count(o.order_id) as total_vendas
from employees e
inner join orders o on e.employee_id = o.employee_id
inner join customers c on o.customer_id = c.customer_id
where
	c.country = 'Brazil'
	and c.postal_code like '__%'
group by e.employee_id, e.first_name, e.last_name
order by total_vendas desc
limit 1'''



#Qual employee que mais gerou resultados para a Northwind em número de pedidos?

query_5 = '''select
	e.employee_id
	, e.first_name
	, e.last_name
	, count(o.order_id) as total_pedidos
from employees e
inner join orders o on e.employee_id = o.employee_id
group by e.employee_id, e.first_name, e.last_name
order by total_pedidos desc
limit 1;'''



#Qual employee que mais gerou resultados para a Northwind em total de itens vendidos?

query_6 = '''select
	e.employee_id
	, e.first_name
	, e.last_name
	, sum(od.quantity) as total_itens_vendidos
from employees e
inner join orders o on e.employee_id = o.employee_id
inner join order_details od on o.order_id = od.order_id
group by e.employee_id, e.first_name, e.last_name
order by total_itens_vendidos desc
limit 1;'''



#Qual employee que mais gerou resultados para a Northwind em valor total dos pedidos

query_7 = '''select
	e.employee_id
	, e.first_name
	, e.last_name
	, sum(od.quantity * od.unit_price) as total_vendas
from employees e
inner join orders o on e.employee_id = o.employee_id
inner join order_details od on o.order_id = od.order_id
group by e.employee_id, e.first_name, e.last_name
order by total_vendas desc
limit 1;'''



# Adicione todas as queries na lista abaixo
queries = [query_1, query_2, query_3, query_4, query_5, query_6, query_7]

#----------------------------------------##
# Não alterar abaixo desta linha

if __name__ == '__main__':
    run_queries(params, queries)


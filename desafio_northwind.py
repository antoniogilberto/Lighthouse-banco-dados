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

query_1 = """SELECT * FROM orders"""

# Crie uma nova query para cada tarefa
# query_2 = """ CREATE TABLE produto..""""

# Adicione todas as queries na lista abaixo
queries = [query_1]

#----------------------------------------##
# Não alterar abaixo desta linha

if __name__ == '__main__':
    run_queries(params, queries)

import os
import psycopg2
from dotenv import dotenv_values

config = {
    **dotenv_values('.env'),
    **os.environ
}


def connect():
    try:
        print('Estabelecendo conexão com a base de dados.')

        conn = psycopg2.connect(host=config['DB_HOST'],
                                port=config['DB_PORT'],
                                dbname=config['DB_NAME'],
                                user=config['DB_USER'],
                                password=config['DB_PASSWORD'])

        print('Conexão estabelecida com sucesso.')

        return conn
    except:
        print('Erro ao estabelecer conexão com a base de dados. Verifique a configuração utilizada.')
        quit()


def close(cursor, connection):
    if cursor:
        cursor.close()
    if connection:
        connection.close()

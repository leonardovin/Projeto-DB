import psycopg2
from prettytable import from_db_cursor

def list(connection, cursor):
    try:
        query = 'SELECT * FROM aluno_cursa AC JOIN aluno A ON AC.aluno = A.usuario'
        cursor.execute(query)
        connection.commit()
        print(f'Alunos:')
        print(from_db_cursor(cursor))
    except Exception as e:
        connection.rollback()
        print(e)

def create(connection, cursor, student):
    insert_user_query = '''
        INSERT INTO usuario (cpf, nome, email, senha, tipo, data_nasc,
            endereco, telefone, idioma1, status)
            VALUES (%(cpf)s, %(nome)s, %(email)s, %(senha)s, %(tipo)s,
            %(data_nasc)s, %(endereco)s, %(telefone)s, %(idioma1)s, %(status)s)
        '''

    insert_student_query = 'INSERT INTO aluno(usuario, assinante) VALUES (%s, %s)'

    try:
        print(tuple(student.values()))
        cursor.execute(insert_user_query, student)
        cursor.execute(insert_student_query, (student['cpf'], False))
        connection.commit()
        print('Usuário inserido com sucesso.')
        return True
    except psycopg2.errors.UniqueViolation:
        connection.rollback()
        print('Já existe um usuário com esse CPF.')
    except Exception as e:
        connection.rollback()
        print(e)

    return False

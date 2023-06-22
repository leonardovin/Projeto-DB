import psycopg2
from prettytable import from_db_cursor

def list(connection, cursor):
    try:
        cursor.execute('SELECT * FROM Curso;')
        connection.commit()
        print('Cursos:')
        print(from_db_cursor(cursor))
    except Exception as e:
        connection.rollback()
        print(e)

def insert_student(connection, cursor, student):
    insert_user_query = 'INSERT INTO usuario(cpf, nome, email, senha, tipo, data_nasc, endereco, telefone, idioma1, status) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'
    insert_student_query = 'INSERT INTO aluno(usuario, assinante) VALUES (%s, %s)';

    try:
        print(tuple(student.values()))
        cursor.execute(insert_user_query, tuple(student.values()))
        cursor.execute(insert_student_query, (student['cpf'], False))
        connection.commit()
        print('Usuário inserido com sucesso.')
    except psycopg2.errors.UniqueViolation:
        print('Já existe um usuário com esse CPF.')
    except Exception as e:
        connection.rollback()
        print(e)

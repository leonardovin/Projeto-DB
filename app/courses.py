import psycopg2
from prettytable import from_db_cursor
from datetime import datetime

def list(connection, cursor):
    try:
        cursor.execute('SELECT * FROM Curso')
        connection.commit()
        print('Cursos:')
        print(from_db_cursor(cursor))
    except Exception as e:
        connection.rollback()
        print(e)

def insert_student(connection, cursor, course, student):
    query = 'INSERT INTO aluno_cursa(aluno, curso, data_hora) VALUES (%s, %s, %s)'

    try:
        cursor.execute(query, (student, course, datetime.now()))
        connection.commit()
        print(f'Usuário {student} inserido no curso {course} com sucesso.')
    except psycopg2.errors.UniqueViolation:
        print('O aluno {student} já está cursando {course}.')
    except Exception as e:
        connection.rollback()
        print(e)

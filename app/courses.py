import psycopg2
from prettytable import from_db_cursor
from datetime import datetime
from util import press_enter_message, print_error

def list(connection, cursor):
    try:
        query = 'SELECT * FROM curso'
        cursor.execute(query)
        connection.commit()
        print('Cursos:')
        print(from_db_cursor(cursor))
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()

def list_students(connection, cursor, course):
    try:
        query = 'SELECT * FROM aluno_cursa AC JOIN aluno A ON AC.aluno = A.usuario WHERE curso = %s'
        print(course)
        print(query)

        cursor.execute(query, (course,))
        connection.commit()

        print(f'Alunos do curso {course}:')
        print(from_db_cursor(cursor))
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()

def insert_student(connection, cursor, course, student):
    query = 'INSERT INTO aluno_cursa(aluno, curso, data_hora) VALUES (%s, %s, %s)'

    try:
        cursor.execute(query, (student, course, datetime.now()))
        connection.commit()
        print(f'Aluno {student} inserido no curso {course} com sucesso.')
    except psycopg2.errors.UniqueViolation as e:
        connection.rollback()
        print_error('o aluno {student} já está cursando {course}.')
    except psycopg2.errors.ForeignKeyViolation as e:
        connection.rollback()
        print('violação de chave estrangeira ({e.diag.constraint_name})')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()

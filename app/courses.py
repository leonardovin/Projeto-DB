import psycopg2
from prettytable import from_db_cursor
from datetime import datetime
from util import press_enter_message, print_error

def list(connection, cursor):
    try:
        query = 'SELECT * FROM curso'
        cursor.execute(query)
        connection.commit()

        if cursor.rowcount > 0:
            print('Cursos:')
            print(from_db_cursor(cursor))
        else:
            print('Ainda não há cursos cadastrados.')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()

def list_students(connection, cursor, course):
    try:
        query = 'SELECT * FROM aluno_cursa AC JOIN aluno A ON AC.aluno = A.usuario WHERE curso = %s'
        cursor.execute(query, (course,))
        connection.commit()

        if cursor.rowcount > 0:
            print(f'Alunos do curso {course}:')
            print(from_db_cursor(cursor))
        else:
            print('Ainda não há alunos cadastrados neste curso.')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()

def insert_student(connection, cursor, course, student):
    query = 'INSERT INTO aluno_cursa(aluno, curso, data_hora) VALUES (%s, %s, %s)'

    try:
        cursor.execute(query, (student, course, datetime.now()))
        connection.commit()
        print(f'\nAluno {student} inserido no curso {course} com sucesso.\n')
    except psycopg2.errors.UniqueViolation as e:
        connection.rollback()
        print_error('o aluno {student} já está cursando {course}.')
    except psycopg2.errors.ForeignKeyViolation as e:
        connection.rollback()
        print_error(f'violação de chave estrangeira ({e.diag.constraint_name})')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()

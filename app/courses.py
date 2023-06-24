import psycopg2
from prettytable import from_db_cursor
from datetime import datetime
from util import press_enter_message, print_error


def list(connection, cursor):
    try:
        query = '''
            SELECT
            codigo AS "Código",
            titulo AS "Título",
            categoria AS "Categoria",
            nivel_dificuldade AS "Nível de dificuldade",
            media_aval AS "Média de avaliações",
            SUBSTRING(descricao, 1, 20) AS "Descrição",
            criado_por AS "Tutor responsável"
            FROM curso
            '''

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


def search(connection, cursor, key):
    try:
        query = '''
            SELECT
            codigo AS "Código",
            titulo AS "Título",
            categoria AS "Categoria",
            nivel_dificuldade AS "Nível de dificuldade",
            media_aval AS "Média de avaliações",
            SUBSTRING(descricao, 1, 20) AS "Descrição",
            criado_por AS "Tutor responsável"
            FROM curso WHERE codigo = %s OR titulo = %s
            '''

        cursor.execute(query, (key, key))
        connection.commit()

        if cursor.rowcount > 0:
            print(f'{cursor.rowcount} resultado(s) para a busca pelo curso "{key}":')
            print(from_db_cursor(cursor))
        else:
            print(f'Não foi possível encontrar nenhum curso "{key}".')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()


def list_students(connection, cursor, course):
    try:
        query = '''
            SELECT
            U.cpf AS "CPF",
            U.nome AS "Nome",
            U.email AS "E-mail",
            CASE WHEN A.assinante IS TRUE THEN 'Sim' ELSE 'Não' END AS "Assinante",
            AC.nota AS "Nota",
            AC.data_hora AS "Data de início"
            FROM aluno_cursa AS AC
            JOIN aluno AS A ON AC.aluno = A.usuario
            JOIN usuario AS U ON A.usuario = U.cpf
            WHERE AC.curso = %s
            '''

        cursor.execute(query, (course,))
        connection.commit()

        if cursor.rowcount > 0:
            print(f'Alunos do curso {course}:')
            print(from_db_cursor(cursor))
        else:
            print('Ainda não há alunos cadastrados neste curso. Não se esqueça de verificar se o curso existe.')
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

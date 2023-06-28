import psycopg2
from prettytable import from_db_cursor
from datetime import datetime
from util import press_enter_message, print_error


def list(connection):
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

        with connection.cursor() as cursor:
            cursor.execute(query)

            if cursor.rowcount > 0:
                print('Cursos:')
                print(from_db_cursor(cursor))
            else:
                print('Ainda não há cursos cadastrados.')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()


def search(connection, key):
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

        with connection.cursor() as cursor:
            cursor.execute(query, (key, key))

            if cursor.rowcount > 0:
                print(f'{cursor.rowcount} resultado(s) para a busca pelo curso "{key}":')
                print(from_db_cursor(cursor))
            else:
                print(f'Não foi possível encontrar nenhum curso "{key}".')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()


def list_students(connection, course):
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
        with connection.cursor() as cursor:
            cursor.execute(query, (course,))

            if cursor.rowcount > 0:
                print(f'Alunos do curso {course}:')
                print(from_db_cursor(cursor))
            else:
                print('Ainda não há alunos cadastrados neste curso. Não se esqueça de verificar se o curso existe.')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()


def insert_student(connection, course, student):
    query = 'INSERT INTO aluno_cursa(aluno, curso, data_hora) VALUES (%s, %s, %s)'

    try:
        with connection.cursor() as cursor:
            cursor.execute(query, (student, course, datetime.now()))
        print(f'\nAluno {student} inserido no curso {course} com sucesso.\n')
    except psycopg2.errors.UniqueViolation as e:
        connection.rollback()
        print_error('o aluno {student} já está cursando {course}.')
    except psycopg2.errors.ForeignKeyViolation as e:
        connection.rollback()
        constraint_name = e.diag.constraint_name

        print_error(f'violação de chave estrangeira ({constraint_name})')

        error_messages = {
            'fk_aluno_cursa_aluno': 'o aluno especificado não existe.',
            'fk_aluno_cursa_curso': 'o curso especificado não existe.'
        }

        print_error(f'{error_messages[constraint_name]} Verifique os dados informados.')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()

import psycopg2
from prettytable import from_db_cursor
from util import press_enter_message, print_error


def list(connection, cursor):
    try:
        query = '''
            SELECT
            U.cpf AS "CPF",
            U.nome AS "Nome",
            U.email AS "E-mail",
            CASE WHEN A.assinante IS TRUE THEN 'Sim' ELSE 'Não' END AS "Assinante"
            FROM aluno AS A JOIN usuario AS U ON A.usuario = U.cpf
            '''

        cursor.execute(query)
        connection.commit()

        if cursor.rowcount > 0:
            print('Alunos:')
            print(from_db_cursor(cursor))
        else:
            print('Ainda não há alunos cadastrados.')
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()


def create(connection, cursor, student):
    insert_user_query = '''
        INSERT INTO usuario (cpf, nome, email, senha, tipo, data_nasc,
            endereco, telefone, idioma1, status)
        VALUES (%(cpf)s, %(nome)s, %(email)s, %(senha)s, %(tipo)s,
            %(data_nasc)s, %(endereco)s, %(telefone)s, %(idioma1)s, %(status)s)
        '''

    insert_student_query = 'INSERT INTO aluno(usuario, assinante) VALUES (%s, %s)'

    try:
        # print(tuple(student.values()))

        cursor.execute(insert_user_query, student)
        cursor.execute(insert_student_query, (student['cpf'], False))
        connection.commit()

        print('\nAluno inserido com sucesso.\n')
        press_enter_message()

        return True
    except psycopg2.errors.UniqueViolation as e:
        connection.rollback()
        print_error('já existe um usuário com esse CPF.')
    except psycopg2.errors.CheckViolation as e:
        connection.rollback()

        constraint_name = e.diag.constraint_name
        print_error(f'violação de check ({constraint_name})')

        error_messages = {
            'cpf_formato': 'formato de CPF inválido.',
            'cartao_cred_cpf_formato': 'formato do número de cartão de crédito inválido.',
            'cartao_cred_val_formato': 'formato de validade do cartão de crédito inválido.',
            'telefone_formato': 'formato de número de telefone inválido.',
            'email_formato': 'formato de e-mail inválido.'
        }

        print_error(f'{error_messages[constraint_name]} Verifique os dados informados.')
    except psycopg2.errors.InvalidDatetimeFormat as e:
        connection.rollback()
        print_error('formato de data inválido. A data deve estar no formato DD/MM/YYYY.')
    except psycopg2.errors.StringDataRightTruncation as e:
        connection.rollback()
        print(e)
        print_error('tamanho inválido. Verifique os dados informados.')
    except psycopg2.Error as e:
        connection.rollback()
        print_error(e.pgcode)
        print_error(e)
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()
    return False

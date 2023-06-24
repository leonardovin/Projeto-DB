import psycopg2
from prettytable import from_db_cursor
from util import press_enter_message, print_error

def list(connection, cursor):
    try:
        query = 'SELECT * FROM aluno_cursa AC JOIN aluno A ON AC.aluno = A.usuario'
        cursor.execute(query)
        connection.commit()
        print('Alunos:')
        print(from_db_cursor(cursor))
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
        print(tuple(student.values()))
        cursor.execute(insert_user_query, student)
        cursor.execute(insert_student_query, (student['cpf'], False))
        connection.commit()

        print('Aluno inserido com sucesso.')
        press_enter_message()

        return True
    except psycopg2.errors.UniqueViolation as e:
        connection.rollback()
        print_error('já existe um usuário com esse CPF.')
    except psycopg2.errors.InvalidDatetimeFormat as e:
        connection.rollback()
        print_error('formato de data inválido. A data deve estar no formato DD/MM/YYYY.')
    except psycopg2.Error as e:
        connection.rollback()
        print_error(e.pgcode)
    except Exception as e:
        connection.rollback()
        print_error(e)

    press_enter_message()
    return False

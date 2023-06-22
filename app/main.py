import psycopg2
import db
import courses

def menu():
    print('''
          1. Listar cursos
          2. Listar alunos de um curso
          3. Inserir aluno em um curso
          q. Sair
          ''')

    option = input('Selecione uma opção: ')

    match option:
        case '1':
            courses.list(connection, cursor)
        case '2':
            # course = input()
            # courses.list_students(connection, cursor, course)
            raise NotImplementedError()
        case '3':
            student = {
                'cpf': '123',
                'nome': 'A',
                'email': 'x@y.com',
                'senha': '123',
                'tipo': 'ALUNO',
                'data_nasc': '10/07/1979',
                'endereco': 'Rua A, 48',
                'telefone': '(00) 12345-6789',
                'idioma1': 'Português (Brasil)',
                'status': 'ATIVO',
            }

            courses.insert_student(connection, cursor, student)
        case 'q':
            db.close(cursor, connection)
            quit()
        case _:
            print('Selecione uma opção válida.')

    menu()

def main():
    global cursor, connection
    connection = db.connect()
    cursor = connection.cursor()
    menu()

if __name__ == '__main__':
    main()

import psycopg2
import db
import courses
import students
from util import clear

def menu():
    print('''
    1. Listar todos os cursos
    2. Listar todos os alunos
    3. Listar alunos de um curso
    4. Buscar curso
    5. Inserir aluno em um curso
    6. Inserir aluno
    q. Sair
    ''')

    option = input('Selecione uma opção: ')

    match option:
        case '1':
            clear()
            courses.list(connection, cursor)
        case '2':
            clear()
            students.list(connection, cursor)
        case '3':
            course = input('Insira a sigla do curso: ')
            clear()
            courses.list_students(connection, cursor, course)
        case '5':
            student = input('Insira o CPF do aluno: ')
            course = input('Insira a sigla do curso: ')
            clear()
            courses.insert_student(connection, cursor, course, student)
        case '6':
            cpf = input('CPF: ')
            nome = input('Nome: ')
            email = input('E-mail: ')
            senha = input('Senha: ')
            data_nasc = input('Data de nascimento: ')
            endereco = input('Endereço: ')
            telefone = input('Telefone: ')
            idioma1 = input('Idioma: ')

            student = {
                'cpf': cpf,
                'nome': nome,
                'email': email,
                'senha': senha,
                'tipo': 'ALUNO',
                'data_nasc': data_nasc,
                'endereco': endereco,
                'telefone': telefone,
                'idioma1': idioma1,
                'status': 'ATIVO',
            }

            # student = {
                # 'cpf': '123',
                # 'nome': 'A',
                # 'email': 'x@y.com',
                # 'senha': '123',
                # 'tipo': 'ALUNO',
                # 'data_nasc': '10/07/1979',
                # 'endereco': 'Rua A, 48',
                # 'telefone': '(00) 12345-6789',
                # 'idioma1': 'Português (Brasil)',
                # 'status': 'ATIVO',
            # }

            if students.create(connection, cursor, student) is False:
                clear()
                menu()

            insert_option = input('Deseja inserir o aluno em um curso? (s/N)')

            if insert_option.lower() == 's':
                list_option = input('Deseja listar os cursos? (s/N)')

                if list_option.lower() == 's':
                    courses.list(connection, cursor)

                course = input('Insira a sigla do curso: ')
                courses.insert_student(connection, cursor, course, student['cpf'])

        case 'q':
            db.close(cursor, connection)
            quit()
        case _:
            clear()
            print('Selecione uma opção válida.')
            menu()

    clear()
    menu()

def main():
    global cursor, connection
    connection = db.connect()
    cursor = connection.cursor()
    clear()
    menu()

if __name__ == '__main__':
    main()

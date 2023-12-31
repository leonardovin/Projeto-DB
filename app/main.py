import psycopg2
import db
import courses
import students
from util import clear, input_not_empty, pwinput_not_empty


def menu():
    '''
    Displays the main menu and handles user input.
    '''

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
            courses.list(connection)
        case '2':
            clear()
            students.list(connection)
        case '3':
            course = input_not_empty('Insira o código do curso: ')
            clear()
            courses.list_students(connection, course)
        case '4':
            course_key = input_not_empty('Insira o código ou nome do curso: ')
            clear()
            courses.search(connection, course_key)
        case '5':
            student = input_not_empty('Insira o CPF do aluno: ')
            course = input_not_empty('Insira o código do curso: ')
            courses.insert_student(connection, course, student)
        case '6':
            cpf = input_not_empty('CPF: ')
            nome = input_not_empty('Nome: ')
            email = input_not_empty('E-mail: ')
            senha = pwinput_not_empty('Senha: ')
            data_nasc = input_not_empty('Data de nascimento: ')
            endereco = input_not_empty('Endereço: ')
            telefone = input_not_empty('Telefone: ')
            idioma1 = input_not_empty('Idioma: ')

            student = {
                'cpf': cpf,
                'nome': nome,
                'email': email,
                'senha': senha,
                'tipo': 'aluno',
                'data_nasc': data_nasc,
                'endereco': endereco,
                'telefone': telefone,
                'idioma1': idioma1,
                'status': 'ativo',
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

            if students.create(connection, student) is False:
                clear()
                menu()

            insert_option = input('Deseja inserir o aluno em um curso? (s/N): ')

            if insert_option.lower() == 's':
                list_option = input('Deseja listar os cursos? (s/N): ')

                if list_option.lower() == 's':
                    print()
                    courses.list(connection)

                course = input_not_empty('Insira o código do curso: ')
                courses.insert_student(connection, course, student['cpf'])
        case 'q':
            db.close(connection)
            quit()
        case _:
            clear()
            print('Selecione uma opção válida.')
            menu()

    clear()
    menu()


def main():
    global connection
    connection = db.connect()
    clear()
    menu()


if __name__ == '__main__':
    main()

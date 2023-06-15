import psycopg2
import db
import courses

def menu():
    print('''
          1. Listar cursos
          q. Sair
          ''')

    option = input('Selecione uma opção: ')

    match option:
        case '1':
            courses.list(cursor)
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

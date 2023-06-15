from prettytable import from_db_cursor

def list(cursor):
    cursor.execute('SELECT * FROM Curso;')

    print('Cursos:')
    print(from_db_cursor(cursor))

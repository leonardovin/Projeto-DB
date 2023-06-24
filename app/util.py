import os

def clear():
    os.system('cls' if os.name == 'nt' else 'clear')

def press_enter_message():
    input('\nPressione ENTER para retornar ao menu.\n')

def print_error(message):
    print(f'\nErro: {message}\n')

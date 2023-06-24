import os
from pwinput import pwinput


def clear():
    os.system('cls' if os.name == 'nt' else 'clear')


def press_enter_message():
    input('\nPressione ENTER para continuar.\n')


def print_error(message):
    print(f'\nErro: {message}\n')


def input_not_empty(message):
    input_text = input(message)

    while input_text.strip() == '':
        input_text = input(message)

    return input_text.strip()

def pwinput_not_empty(message):
    input_text = pwinput(message)

    while input_text.strip() == '':
        input_text = pwinput(message)

    return input_text.strip()

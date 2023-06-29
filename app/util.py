import os
from pwinput import pwinput


def clear():
    '''
    Clears the console screen.
    '''

    os.system('cls' if os.name == 'nt' else 'clear')


def press_enter_message():
    '''
    Displays a message and waits for the user to press Enter.
    '''

    input('\nPressione ENTER para continuar.\n')


def print_error(message):
    '''
    Prints an error message.

    Parameters
    ----------
    message : str
        The error message.
    '''

    print(f'\nErro: {message}\n')


def input_not_empty(message):
    '''
    Prompts the user for input and ensures it is not empty.

    Parameters
    ----------
    message : str
        The input prompt.

    Returns
    -------
    str
        The non-empty user input.
    '''

    input_text = input(message)

    while input_text.strip() == '':
        input_text = input(message)

    return input_text.strip()


def pwinput_not_empty(message):
    '''
    Prompts the user for password input and ensures it is not empty.

    Parameters
    ----------
    message : str
        The input prompt.

    Returns
    -------
    str
        The non-empty password input.
    '''

    input_text = pwinput(message)

    while input_text.strip() == '':
        input_text = pwinput(message)

    return input_text.strip()

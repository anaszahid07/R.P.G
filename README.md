#Password Generator

## Overview

This program is designed to generate secure and customizable passwords based on user input. The password complexity and length can be configured, with the option to generate random passwords composed of uppercase letters, mixed case letters, or a complex combination of letters, numbers, and special characters.


## Menu Options

The program presents the following menu for users to choose from:
1. **ALL UPPERCASE LETTERS** – Generate a password using only uppercase letters.
2. **MIXED CASE LETTERS** – Generate a password using both uppercase and lowercase letters.
3. **COMPLEX (Letters, Numbers, Symbols)** – Generate a password that includes uppercase letters, lowercase letters, numbers, and special characters.



## How It Works

1. **Randomization**: The program initializes a random seed based on the system's current time, ensuring that each password generated is unique.
2. **Password Generation**: Based on the selected complexity level, the program generates random characters from specific character sets:
   - **Option 1**: Uppercase letters (A-Z).
   - **Option 2**: Uppercase and lowercase letters (A-Z, a-z).
   - **Option 3**: Uppercase, lowercase letters, numbers (0-9), and special characters (!@#$%^&*()_+-={}[]:;<>?).
3. **Repeat**: After displaying the generated password, the user is prompted to either generate another password or exit the program.

## Example Output

```plaintext
    _    _      _                            _          ______    ______     ______   _ 
   | |  | | ___| | ___ ___  _ __ ___   ___  | |_ ___   |   _  \  |   _  \   /  ____| | |
   | |/\| |/ _ \ |/ __/ _ \| '_ ` _ \ / _ \ | __/ _ \  |  |_)  | |  |_)  | |  |  __  | |
   \  /\  /  __/ | (_| (_) | | | | | |  __/ | || (_) | |   ___/  |   ___/  |  | |_ | | |
    \/  \/ \___|_|\___\___/|_| |_| |_|\___|  \__\___/  |  |\ \   |  |      |  |__| | |_|
                                                       |__| \_\  |__|       \______| (_)

Enter Desired Password Length (8-50): 12
        ********************* PASSWORD MENU *********************
       1. ** ALL UPPERCASE LETTERS **
       2. ** MIXED CASE LETTERS **
       3. ** COMPLEX (Letters, Numbers, Symbols) **

  CHOOSE COMPLEXITY (1-3): 3

    PASSWORD GENERATED: $tJb3&9wz#D0
Press y to generate another password or n to exit: n

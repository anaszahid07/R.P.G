INCLUDE Irvine32.inc

.data
    password BYTE 50 DUP(?)                                      ; Buffer to store the generated password
    passwordLength DWORD ?                                       ; Desired password length
    passwordComplexity DWORD ?                                   ; Password complexity level
    uppercase BYTE 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 0               ; Uppercase letters for password generation
    lowercase BYTE 'abcdefghijklmnopqrstuvwxyz', 0               ; Lowercase letters for password generation
    numbers BYTE '0123456789', 0                                 ; Numeric characters for password generation
    specialChars BYTE '!@#$%^&*()_+-={}:<>?', 0                  ; Special characters for password generation
    sprompt      BYTE "  Enter Desired Password Length (8-50): ", 0
    smenu        BYTE "        ********************* PASSWORD MENU *********************", 0      
    smenu1       BYTE "       1. ** ALL UPPERCASE LETTERS **", 0          
    smenu2       BYTE "       2. ** MIXED CASE LETTERS **", 0 
    smenu3       BYTE "       3. ** COMPLEX (Letters, Numbers, Symbols) **", 0 

    soption      BYTE "  CHOOSE COMPLEXITY (1-3): ", 0 
    spassword    BYTE "    PASSWORD GENERATED: ", 0 
    errorMsg     BYTE " ** INVALID INPUT! Exiting Program. Please Try Again. **", 0
    sRepeatPrompt BYTE "Press y to generate another password or n to exit: ", 0

    ; Banner to display logo
    welcomeBanner1 BYTE "    _    _      _                            _          ______    ______     ______   _ ", 13, 10, 0
    welcomeBanner2 BYTE "   | |  | | ___| | ___ ___  _ __ ___   ___  | |_ ___   |   _  \  |   _  \   /  ____| | |", 13, 10, 0
    welcomeBanner3 BYTE "   | |/\| |/ _ \ |/ __/ _ \| '_ ` _ \ / _ \ | __/ _ \  |  |_)  | |  |_)  | |  |  __  | |", 13, 10, 0
    welcomeBanner4 BYTE "   \  /\  /  __/ | (_| (_) | | | | | |  __/ | || (_) | |   ___/  |   ___/  |  | |_ | | |", 13, 10, 0
    welcomeBanner5 BYTE "    \/  \/ \___|_|\___\___/|_| |_| |_|\___|  \__\___/  |  |\ \   |  |      |  |__| | |_|", 13, 10, 0
    welcomeBanner6 BYTE "                                                       |__| \_\  |__|       \______| (_)", 13, 10, 0

.code
start PROC
    ; Print the welcome banner first
    ; Load and display the welcome banner
    mov edx, OFFSET welcomeBanner1
    call WriteString
    mov edx, OFFSET welcomeBanner2
    call WriteString
    mov edx, OFFSET welcomeBanner3
    call WriteString
    mov edx, OFFSET welcomeBanner4
    call WriteString
    mov edx, OFFSET welcomeBanner5
    call WriteString
    mov edx, OFFSET welcomeBanner6
    call WriteString
    call Crlf

    ; Initializing the random seed
    call RandomizeSeed

mainLoop:
    ; Display prompt for password length
    mov edx, OFFSET sprompt
    call WriteString
    ; Read the user's input for password length
    call ReadInt
    ; Validate the password length (must be >= 8)
    cmp eax, 8
    jl invalidInput
    ; Max password length is still 50 (must be <= 50)
    cmp eax, 50
    jg invalidInput
    ; Store password length given by user
    mov passwordLength, eax

    ; Display menu options
    mov edx, OFFSET smenu
    call WriteString
    call Crlf

    mov edx, OFFSET smenu1
    call WriteString
    call Crlf

    mov edx, OFFSET smenu2
    call WriteString
    call Crlf

    mov edx, OFFSET smenu3
    call WriteString
    call Crlf

    mov edx, OFFSET soption
    call WriteString
    call ReadInt
    ; Check complexity level (must be >= 1 and <= 3)
    cmp eax, 1
    jl invalidInput
    cmp eax, 3
    jg invalidInput
    mov passwordComplexity, eax

    ; Generate password
    ; Set the address to store the generated password
    mov esi, OFFSET password
    ; Number of times the loop runs (i.e., the length of password)
    mov ecx, passwordLength

generatePassword:
    ; Generate a random character based on complexity
    call GenerateRandomChar
    ; Store the generated character in the buffer
    mov [esi], al
    ; Move to the next buffer position
    inc esi
    ; Repeat until all characters are generated
    loop generatePassword

    mov byte ptr [esi], 0

    ; Displaying the generated password
    call Crlf
    mov edx, OFFSET spassword
    call WriteString
    ; Load and display the generated password
    mov edx, OFFSET password
    call WriteString
    call Crlf

    ; Ask if the user wants to generate another password
    mov edx, OFFSET sRepeatPrompt
    call WriteString
    ; Read the user's choice (y or n)
    call ReadChar
    cmp al, 'y'                 ; Compare input with 'y'
    je mainLoop                 ; If 'y', continue the loop
    cmp al, 'n'                 ; Compare input with 'n'
    je exitProgram              ; If 'n', exit the program

    ; If invalid input (not 'y' or 'n'), ask again
    jmp mainLoop

exitProgram:
    ; Exit the program successfully
    invoke ExitProcess, 0

invalidInput:
    ; Display error message for invalid input
    mov edx, OFFSET errorMsg
    call WriteString
    ; Exit the program with an error code
    invoke ExitProcess, 1

start ENDP

RandomizeSeed PROC
    ; Use the system time to initialize the random seed, this is the basis for password generation
    call GetMSeconds                         ; Get milliseconds from system time
    call Randomize                           ; Set the seed for random number generation
    ret
RandomizeSeed ENDP

GenerateRandomChar PROC
    mov eax, passwordComplexity
    ; uppercase only
    cmp eax, 1
    je uppercaseOnly
    ; mixed case
    cmp eax, 2
    je mixedCase
    ; alphanumeric + special characters
    cmp eax, 3
    je allCharacters

uppercaseOnly:
    ; Set the range for uppercase letters (26 characters)
    mov eax, 26
    call RandomRange                         ; Generate a random number in the range
    add al, 'A'                              ; Convert to uppercase letter
    ret

mixedCase:
    ; Set the range for mixed case (52 characters: uppercase + lowercase)
    mov eax, 52
    call RandomRange
    ; If the number is less than 26, generate an uppercase letter
    cmp al, 26
    jl upperCaseProc
    ; Otherwise, generate a lowercase letter
    sub al, 26
    add al, 'a'
    ret

allCharacters:
    ; Set the range for all characters (94 characters: uppercase, lowercase, digits, special)
    mov eax, 94
    call RandomRange
    add al, '!'                              ; Map to the character set starting at '!'
    ret

upperCaseProc:
    ; Convert to uppercase letter
    add al, 'A'
    ret

lowerCaseProc:
    ; Convert to lowercase letter
    add al, 'a'
    ret

GenerateRandomChar ENDP

END start

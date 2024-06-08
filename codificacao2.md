# Codificação das instruções

Todas as instruções tem 16 bits

## Tipo R

|xxxxxxxxx|rrr|oooo|

-   9 bits sem uso
-   3 bits para identificação
-   4 bits para opcode

## Tipo I

|iiiiiiiii|xxx|oooo|

-   9 bits para imediato
-   3 bits sem uso
-   4 bits para opcode

## Tipo RI

|iiiiiiiii|rrr|oooo|

-   9 bits para imediato
-   3 bits para identificação
-   4 bits para opcode

## Tipo D

|xxxxxx|rrr|rrr|oooo|

-   6 bits para imediato
-   3 bits para identificação
-   3 bits para identificação
-   4 bits para opcode

## Instrução NOP

A instrução NOP é decodificada para 0x0000

# Tabela de identificação de registradores

Há 8 registradores de 16 bits cada.
OBS: o registrador zero não pode ser sobrescrito, terá sempre valor 0.

| Registrador | Decodificação |
| ----------- | ------------- |
| zero        | 000           |
| r1          | 001           |
| r2          | 010           |
| r3          | 011           |
| r4          | 100           |
| r5          | 101           |
| r6          | 110           |
| r7          | 111           |

# Tabela de identificação de registradores de flags

| Registrador | Decodificação |
| ----------- | ------------- |
| zero        | 000           |
| carry       | 001           |
| greater     | 010           |

# Tabela de identificação de branches de flags

| Registrador | Decodificação |
| ----------- | ------------- |
| BEQ         | 000           |
| BGT         | 010           |
| BLT         | 101           |
| BNE         | 111           |

# Tabela de decodificação de instruções

| Instrução | opcode | Tipo |
| --------- | ------ | ---- |
| NOP       | 0000   | NOP  |
| JMP I     | 0001   | I    |
| MOV R, A  | 0010   | R    |
| MOV A, R  | 0011   | R    |
| ADD A, R  | 0100   | R    |
| SUB A, R  | 0101   | R    |
| SUBB A, R | 0110   | R    |
| SW E, R   | 0111   | D    |
| LW R, E   | 1000   | D    |
| LU R, I   | 1001   | RI   |
| JB F      | 1100   | R    |
| CLR F     | 1101   | R    |
| LD A, I   | 1110   | I    |
| LD R, I   | 1111   | RI   |

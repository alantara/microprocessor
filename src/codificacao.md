# Codificação das instruções

Todas as instruções tem 16 bits

## Tipo I

Instruções que levam um imediato de X bits.

|xxxxxxxxxxxx|xxxx|

- 12 bits de imediato
- 4 bits para opcode

### Exemplo de instrução tipo I

- LD A, -1

A instrução seria decodificada para 0xFFF0. Considerando a tabela de decodificaçâo ao final.

## Tipo R

|xxxxxxxxx|xxx|xxxx|

- 9 bits sem uso &#x1F44D;
- 3 bits para R
- 4 bits para opcode

### Exemplo de instrução tipo R

- ADD R1

Adiciona o valor do acumulador com o valor do registrador R e salva no acumulador

A instrução seria decodificada para 0x0D14. Considerando a tabela de identificação de registradores ao final.

## Tipo S

Apenas para LD R, C

|xxxxxxxxx|xxx|xxxx|

- 9 bits de imediato
- 3 bits para R
- 4 bits para opcode

### Exemplo de instrução tipo S

- LD r1, 510

A instrução seria decodificada para 0xFF0F

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

# Tabela de decodificação de instruções

## Tipo R

| Instrução | opcode |
| --------- | ------ |
| MOV R, A  | 0010   |
| MOV A, R  | 0011   |
| ADD       | 0100   |
| SUB       | 0101   |
| SUBB      | 0111   |

## Tipo I

| Instrução | opcode |
| --------- | ------ |
| LD A, C   | 0000   |
| JMP       | 0001   |

## Tipo S

| Instrução | opcode |
| --------- | ------ |
| LD R, C   | 1111   |

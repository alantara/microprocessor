# Codificação das instruções

Todas as instruções tem 16 bits

## Tipo R

|xxxxxxxxx|xxx|xxxx|

- 9 bits de imediato (utilizado apenas se for LD R, C)
- 3 bits para R
- 4 bits para opcode

### Exemplo de instrução tipo R

- ADD R1

Adiciona o valor do acumulador com o valor do registrador R e salva no acumulador

A instrução seria decodificada para 0x0D14. Considerando a tabela de identificação de registradores ao final.

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

# Tabela de decodificação de instruções

## Tipo R

| Instrução | opcode |
| --------- | ------ |
| JMP       | 0001   |
| MOV R, A  | 0010   |
| MOV A, R  | 0011   |
| ADD       | 0100   |
| SUB       | 0101   |
| SUBB      | 0111   |
| CLR F     | 1000   |
| BEQ       | 1001   |
| BLT       | 1010   |
| BGT       | 1011   |
| LD R, C   | 1111   |
| LD A, C   | 1110   |

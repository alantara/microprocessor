# Codificação das instruções

Todas as instruções tem 16 bits

## Tipo I

Instruções que levam um imediato de 6 bits. Instruções de branch e jump também são tipo I, pois carregam 6 bits que identificam o endereço da próxima instrução

|xxxxxx|xxx|xxx|xxxx|

- 6 bits de imediato
- 3 bits para o registrador rs1
- 3 bits para o registrador rd
- 4 bits para opcode

### Exemplo de instrução tipo I

- ADDI r1, r2, 20

A instrução seria decodificada para 0x50A0. Considerando a tabela de identificação de registradores ao final.

## Tipo R

|xxx|xxx|xxx|xxx|xxxx|

- 3 bits de funct3 - extensão do opcode
- 3 bits para rs2
- 3 bits para rs1
- 3 bits para rd
- 4 bits para opcode

### Exemplo de instrução tipo R

- ADD r1, r2, r3

A instrução seria decodificada para 0x0D10. Considerando a tabela de identificação de registradores ao final.

## Tipo S

|xxxxxxxxx|xxx|xxxx|

- 9 bits de imediato
- 3 bits para rd
- 4 bits para opcode

### Exemplo de instrução tipo S

- LD r1, 123

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

| Instrução | opcode | funct3 |
| --------- | ------ | ------ |
| ADD       | 0001   | 000    |
| SUB       | 0001   | 001    |
| MUL       | 0010   | 000    |
| MOV       | 0011   | 000    |

## Tipo I

| Instrução | opcode |
| --------- | ------ |
| ADDI      | 1000   |
| SUBI      | 1001   |
| MULI      | 1010   |
| BEQ       | 1100   |
| BGE       | 1101   |
| BLE       | 1110   |
| JMP       | 1111   |

## Tipo S

| Instrução | opcode |
| --------- | ------ |
| LD        | 0100   |

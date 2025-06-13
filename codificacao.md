# Instruction code
All Instructions have 16 bits

## Type R

|xxxxxxxxx|rrr|oooo|

-   9 bits without use
-   3 bits for identification
-   4 bits for opcode

## Type I

|iiiiiiiii|xxx|oooo|

-   9 bits for immediate
-   3 bits without use
-   4 bits for opcode

## Type RI

|iiiiiiiii|rrr|oooo|

-   9 bits for immediate
-   3 bits for identification
-   4 bits for opcode

## Type D

|xxxxxx|rrr|rrr|oooo|

-   6 bits without use
-   3 bits for identification
-   3 bits for identification
-   4 bits for opcode

## Instruction NOP
NOP instruction is 0x0000

# Registers Identifier Table
There are 8 registers, each with 16 bits.
Register zero cannot be modified, always will have 0 value.

| Register    | Codification  |
| ----------- | ------------- |
| zero        | 000           |
| r1          | 001           |
| r2          | 010           |
| r3          | 011           |
| r4          | 100           |
| r5          | 101           |
| r6          | 110           |
| r7          | 111           |

# Flag Identifier Table

| Flag        | Codification  |
| ----------- | ------------- |
| zero        | 000           |
| carry       | 001           |
| greater     | 010           |

# Branch Identifier Table

| Branch      | Codification  |
| ----------- | ------------- |
| BEQ         | 000           |
| BGT         | 010           |
| BLT         | 101           |
| BNE         | 111           |

# Instruction Table

| Instruction | opcode | Type |
| ---------   | ------ | ---- |
| NOP         | 0000   | NOP  |
| JMP I       | 0001   | I    |
| MOV R, A    | 0010   | R    |
| MOV A, R    | 0011   | R    |
| ADD A, R    | 0100   | R    |
| SUB A, R    | 0101   | R    |
| SUBB A, R   | 0110   | R    |
| SW E, R     | 0111   | D    |
| LW R, E     | 1000   | D    |
| ADDI R, I   | 1001   | RI   |
| CMP R, R    | 1010   | D    |
| JB F        | 1100   | R    |
| SUBI R, I   | 1101   | RI   |
| LD A, I     | 1110   | I    |
| LD R, I     | 1111   | RI   |

## C

```c
    void crivo(int n){
        int prime[N+1];

        // INICIALIZA MEMORIA RAM
        prime[0] = prime[1] = 0;
        for (int i = 2; i <= N; i++) prime[i] = 1;

        // CRIVO
        for (int i = 2; i <= N; i++)
            if (prime[i] == 0) continue;
            for (int j = 2*i; j <= N; j+=i)
                prime[j] = 0;

    }

```

## Assembly

Itera a memoria inteira (até n).
A informacao guardada no endereço X é se o número X é primo ou não

```assembly
        LD R1, N

    -- INICIALIZA MEMORIA
    -- 0x0000: 0
    -- 0x0001: 0
        LD R3, 0
        SW R3, zero
        LD R3, 1
        SW R3, zero

    -- TODO O RESTO: 1
        LD R2, 1
        LD R3, 1
    X:  LD A, 1
        ADD A, R3
        MOV R3, A
        SW R3, R2
        BNE R3, R1, X

    LD R5, 0

    -- INICIA O CRIVO
        LD R2, 1
    Y:  LD A, 1
        ADD A, R2
        MOV R2, A
        CLR Z
        MOV A, R1
        SUB R2, A
        BGT END
        LW R3, R2
        CLR Z
        MOV A, zero
        SUB R3, A
        BEQ Y
        MOV A, R2
        MOV R4, A
    Z:  MOV A, R2
        ADD A, R4
        MOV R4, A
        MOV A, R1
        CLR Z
        SUB R4, R1
        BGT Y
        SW R4, zero
        JMP Z  --testar por favor fodase

  END:  NOP
        LD R5, 0x01ED
        LW R6, R1
    -- FIM DO CRIVO


```

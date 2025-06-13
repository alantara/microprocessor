# microprocessor
This project is a minimal microprocessor implemented in VHDL, built as a learning tool to understand mechanisms of a microprocessor.
It features a small set of instructions, which are sufficient to build simple math algorithms.

# Architecture
The microprocessor has a four stage execution
- Instruction Fetch
- Instruction Decode
- Pre Execute
- Execute
Even though it has a four staged execution, it does not implement the pipelining technique.
The stages are a way to facilitate the execution of a single command.
Each command needs 4 clocks to execute.

The microprocessor has the following blocks
- Control Unit: controls flags and sgnals for the execution of all other blocks
- Data Register: a set of registers that can be written on and read from, where all math instructions operate
- RAM: a random acess memory that can be read and written to
- ROM: a read only memory which stores all the code instructions
- State Machine: a state machine that controls in which stage the processor is currently in
- ULA: the Arithmetic Logic Unit is where all math operations run
- Accumulator: block before the ULA which can accumulate values and be used again in ULA operations

The list for all instructions and instruction types can be found in this file: [codificacao.md](codificacao.md)

# Installation
Clone this repository and download the two dependencies *ghld* and *gtkwave*.
Use the automated bash *build.sh* and *run.sh* to build and run the project.
The scripts can build and run individual components and the whole microprocessor.

Scripts dont create the folders where to build.
To build properly create the following folders:
```
.
├── src/
│   ├── components/
│   │     ├── build/
│   │     |     ├── reg1/
│   │     |     ├── reg6/
│   │     |     ├── reg16/
│   ├── modules/
│   │     ├── build/
│   │     |     ├── data_register/
│   │     |     ├── rom/
│   │     |     ├── state_machine/
│   │     |     ├── ula/

```
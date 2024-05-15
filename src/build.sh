#!/bin/bash

rm ./work-obj93.cf

ghdl -a components/regb16/regb16.vhd

ghdl -a modules/state_machine/state_machine.vhd
ghdl -a modules/pc/pc.vhd
ghdl -a modules/plus_one/plus_one.vhd
ghdl -a modules/data_register/data_register.vhd
ghdl -a modules/control_unit/control_unit.vhd
ghdl -a modules/rom/rom.vhd
ghdl -a modules/ula/ula.vhd
ghdl -a microprocessor.vhd
ghdl -a processador_tb.vhd

ghdl -e regb16

ghdl -e pc
ghdl -e plus_one
ghdl -e state_machine
ghdl -e data_register
ghdl -e control_unit
ghdl -e rom
ghdl -e ula
ghdl -e microprocessor
ghdl -e tb

ghdl -r tb --wave=tb.ghw

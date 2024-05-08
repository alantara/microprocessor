#!/bin/bash

ghdl -a components/tff.vhd
ghdl -a components/regb16/regb16.vhd

ghdl -a modules/data_register/data_register.vhd
ghdl -a modules/rom/rom.vhd
ghdl -a modules/ula/ula.vhd
ghdl -a microprocessor.vhd
ghdl -a tb.vhd

ghdl -e tff
ghdl -e regb16

ghdl -e data_register
ghdl -e rom
ghdl -e ula
ghdl -e microprocessor
ghdl -e tb

ghdl -r tb --wave=wave.ghw

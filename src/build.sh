#!/bin/bash

ghdl -a components/demux8x1b1.vhd
ghdl -a components/mux2x1b16.vhd
ghdl -a components/mux8x1b16.vhd
ghdl -a components/regb16.vhd
ghdl -a components/tff.vhd

ghdl -a modules/data_register/data_register.vhd
ghdl -a modules/rom/rom.vhd
ghdl -a modules/ula/ula.vhd
ghdl -a microprocessor.vhd
ghdl -a tb.vhd

ghdl -e demux8x1b1
ghdl -e mux2x1b16
ghdl -e mux8x1b16
ghdl -e regb16

ghdl -e data_register
ghdl -e rom
ghdl -e ula
ghdl -e microprocessor
ghdl -e tb

ghdl -r tb --wave=wave.ghw

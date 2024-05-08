#!/bin/bash

entity=control_unit

ghdl -a ../../components/tff.vhd
ghdl -a ../state_machine/state_machine.vhd
ghdl -a $entity.vhd

ghdl -e tff
ghdl -e state_machine
ghdl -e $entity

ghdl -a tb.vhd
ghdl -e tb

ghdl -r tb --wave=tb.ghw

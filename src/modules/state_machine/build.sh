#!/bin/bash

entity=state_machine

ghdl -a ../../components/tff/tff.vhd
ghdl -e tff

ghdl -a $entity.vhd
ghdl -e $entity

ghdl -a tb.vhd
ghdl -e tb

ghdl -r tb --wave=tb.ghw

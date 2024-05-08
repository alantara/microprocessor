#!/bin/bash

entity=data_register

ghdl -a ../../components/regb16/regb16.vhd
ghdl -e regb16

ghdl -a $entity.vhd
ghdl -e $entity

ghdl -a tb.vhd
ghdl -e tb

ghdl -r tb --wave=tb.ghw

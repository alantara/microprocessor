#!/bin/bash

entity=pc

ghdl -a $entity.vhd
ghdl -e $entity

ghdl -a tb.vhd
ghdl -e tb

ghdl -r tb --wave=tb.ghw
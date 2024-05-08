#!/bin/bash

entity=regb16

ghdl -a $entity.vhd
ghdl -e $entity

ghdl -a tb.vhd
ghdl -e tb

ghdl -r tb --wave=tb.ghw

if [ -f tb.gtkw ]; then
  echo "exists"
  gtkwave tb.gtkw
else
  echo "NOT exists"
  gtkwave tb.ghw
fi

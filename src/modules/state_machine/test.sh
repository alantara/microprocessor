#!/bin/bash

module=state_machine
entity=state_machine

cd ../../
bash build.sh
cd modules/$module/

ghdl -a $entity.vhd
ghdl -e $entity

ghdl -a tb.vhd
ghdl -e tb

ghdl -r tb --wave=tb.ghw
mkdir -p .build/
mv tb.ghw .build/

if [ -f ./.build/tb.gtkw ]; then
  echo "exists"
  gtkwave ./.build/tb.gtkw
else
  echo "NOT exists"
  gtkwave ./.build/tb.ghw
fi


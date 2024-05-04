#!/bin/bash

module=ula
entity=ula

cd ../../
bash build.sh
cd modules/$entity/

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


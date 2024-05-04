#!/bin/bash

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


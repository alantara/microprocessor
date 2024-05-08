#!/bin/bash

bash build.sh


if [ -f tb.gtkw ]; then
  echo "exists"
  gtkwave tb.gtkw
else
  echo "NOT exists"
  gtkwave tb.ghw
fi


#!/bin/bash

bash build.sh

if [ -f tb.gtkw ]; then
  gtkwave tb.gtkw
else
  gtkwave tb.ghw
fi

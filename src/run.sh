#!/bin/bash

read -p "Run top level? (Y/N): " isTopLevel

if [[ $isTopLevel == [yY] ]]; then
#Run Top Level Here
if [ -f top_level/build/tb.gtkw ]; then
  gtkwave ./top_level/build/tb.gtkw
elif [ -f top_level/build/tb.ghw ]; then
  gtkwave ./top_level/build/tb.ghw
else
  echo "[Message] Run Files Missing, Try Building First" 
fi

else
echo ""
echo "Select Component to Run:" 
echo "1-Control Unit" 
echo "2-Data Register" 
echo "3-ROM"
echo "4-State Machine" 
echo "5-ULA"
echo "6-Regb1"
echo "7-Regb6"
echo "8-Regb16"
echo ""
read -p "Run Component: " componentNumber

read -p "Run? (Y/N): " confirm && [[ $confirm == [yY] ]] || exit 1

if [ $componentNumber == "1" ]; then
#RUN CONTROL UNIT HERE
if [ -f modules/build/control_unit/tb.gtkw ]; then
  gtkwave ./modules/build/control_unit/tb.gtkw
elif [ -f modules/build/control_unit/tb.ghw ]; then
  gtkwave ./modules/build/control_unit/tb.ghw
else
  echo "[Message] Run Files Missing, Try Building First" 
fi

elif [ $componentNumber == "2" ]; then
#RUN DATA REGISTER HERE
if [ -f modules/build/data_register/tb.gtkw ]; then
  gtkwave ./modules/build/data_register/tb.gtkw
elif [ -f modules/build/data_register/tb.ghw ]; then
  gtkwave ./modules/build/data_register/tb.ghw
else
  echo "[Message] Run Files Missing, Try Building First" 
fi

elif [ $componentNumber == "3" ]; then
#RUN ROM HERE
if [ -f modules/build/rom/tb.gtkw ]; then
  gtkwave ./modules/build/rom/tb.gtkw
elif [ -f modules/build/rom/tb.ghw ]; then
  gtkwave ./modules/build/rom/tb.ghw
else
  echo "[Message] Run Files Missing, Try Building First" 
fi

elif [ $componentNumber == "4" ]; then
#RUN STATE MACHINE HERE
if [ -f modules/build/state_machine/tb.gtkw ]; then
  gtkwave ./modules/build/state_machine/tb.gtkw
elif [ -f modules/build/state_machine/tb.ghw ]; then
  gtkwave ./modules/build/state_machine/tb.ghw
else
  echo "[Message] Run Files Missing, Try Building First" 
fi

elif [ $componentNumber == "5" ]; then
#RUN ULA HERE
if [ -f modules/build/ula/tb.gtkw ]; then
  gtkwave ./modules/build/ula/tb.gtkw
elif [ -f modules/build/ula/tb.ghw ]; then
  gtkwave ./modules/build/ula/tb.ghw
else
  echo "[Message] Run Files Missing, Try Building First" 
fi

elif [ $componentNumber == "6" ]; then
#RUN REGB1 HERE
if [ -f components/build/regb1/tb.gtkw ]; then
  gtkwave ./components/build/regb1/tb.gtkw
elif [ -f components/build/regb1/tb.ghw ]; then
  gtkwave ./components/build/regb1/tb.ghw
else
  echo "[Message] Run Files Missing, Try Building First" 
fi

elif [ $componentNumber == "7" ]; then
#RUN REGB16 HERE
if [ -f components/build/regb6/tb.gtkw ]; then
  gtkwave ./components/build/regb6/tb.gtkw
elif [ -f components/build/regb6/tb.ghw ]; then
  gtkwave ./components/build/regb6/tb.ghw
else
  echo "[Message] Run Files Missing, Try Building First" 
fi

elif [ $componentNumber == "8" ]; then
#RUN REGB16 HERE
if [ -f components/build/regb16/tb.gtkw ]; then
  gtkwave ./components/build/regb16/tb.gtkw
elif [ -f components/build/regb16/tb.ghw ]; then
  gtkwave ./components/build/regb16/tb.ghw
else
  echo "[Message] Run Files Missing, Try Building First" 
fi


fi

fi
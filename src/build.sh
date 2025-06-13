#!/bin/bash

read -p "Build top level? (Y/N): " isTopLevel

if [[ $isTopLevel == [yY] ]]; then
echo "[Message] Building Top Level"
#Build Top Level Here

cd ./top_level/build

rm tb.ghw work-obj*

ghdl -a ../../components/regb1/regb1.vhd
ghdl -e regb1
ghdl -a ../../components/regb6/regb6.vhd
ghdl -e regb6
ghdl -a ../../components/regb16/regb16.vhd
ghdl -e regb16

ghdl -a ../../modules/state_machine/state_machine.vhd
ghdl -e state_machine
ghdl -a ../../modules/control_unit/control_unit.vhd
ghdl -e control_unit
ghdl -a ../../modules/rom/rom.vhd
ghdl -e rom
ghdl -a ../../modules/ram/ram.vhd
ghdl -e ram
ghdl -a ../../modules/data_register/data_register.vhd
ghdl -e data_register
ghdl -a ../../modules/ula/ula.vhd
ghdl -e ula

ghdl -a ../processador.vhd
ghdl -e processador
ghdl -a ../processador_tb.vhd
ghdl -e processador_tb
ghdl -r processador_tb --wave=tb.ghw --disp-time


echo "[Message] Top Level Built"

else
echo ""
echo "Select Component to build:" 
echo "1-Control Unit" 
echo "2-Data Register" 
echo "3-ROM"
echo "4-State Machine" 
echo "5-ULA"
echo "6-Regb1"
echo "7-Regb6"
echo "8-Regb16"
echo ""
read -p "Build Component: " componentNumber

read -p "Build? (Y/N): " confirm && [[ $confirm == [yY] ]] || exit 1

if [ $componentNumber == "1" ]; then
echo "[Message] Building Control Unit"
#BUILD CONTROL UNIT HERE

echo "[Message] Control Unit Built"

elif [ $componentNumber == "2" ]; then
echo "[Message] Building Data Register"
#BUILD DATA REGISTER HERE

cd ./modules/build/data_register

rm tb.ghw work-obj*

ghdl -a ../../../components/regb16/regb16.vhd
ghdl -e regb16

ghdl -a ../../data_register/data_register.vhd
ghdl -e data_register
ghdl -a ../../data_register/tb.vhd
ghdl -e tb
ghdl -r tb --wave=tb.ghw

echo "[Message] Data Register Built"

elif [ $componentNumber == "3" ]; then
echo "[Message] Building ROM"
#BUILD ROM HERE

cd ./modules/build/rom

rm tb.ghw work-obj*

ghdl -a ../../rom/rom.vhd
ghdl -e rom
ghdl -a ../../rom/tb.vhd
ghdl -e tb
ghdl -r tb --wave=tb.ghw

echo "[Message] ROM Built"

elif [ $componentNumber == "4" ]; then
echo "[Message] Building State Machine"
#BUILD STATE MACHINE HERE

cd ./modules/build/state_machine

rm tb.ghw work-obj*

ghdl -a ../../state_machine/state_machine.vhd
ghdl -e state_machine
ghdl -a ../../state_machine/tb.vhd
ghdl -e tb
ghdl -r tb --wave=tb.ghw

echo "[Message] State Machine Built"

elif [ $componentNumber == "5" ]; then
echo "[Message] Building ULA"
#BUILD ULA HERE

cd ./modules/build/ula

rm tb.ghw work-obj*

ghdl -a ../../ula/ula.vhd
ghdl -e ula
ghdl -a ../../ula/tb.vhd
ghdl -e tb
ghdl -r tb --wave=tb.ghw

echo "[Message] ULA Built"

elif [ $componentNumber == "6" ]; then
echo "[Message] Building Regb1"
#BUILD REGB1 HERE

cd ./components/build/regb1

rm tb.ghw work-obj*

ghdl -a ../../regb1/regb1.vhd
ghdl -e regb1
ghdl -a ../../regb1/tb.vhd
ghdl -e tb
ghdl -r tb --wave=tb.ghw

echo "[Message] Regb1 Built"

elif [ $componentNumber == "7" ]; then
echo "[Message] Building Regb6"
#BUILD REGB16 HERE

cd ./components/build/regb6

rm tb.ghw work-obj*

ghdl -a ../../regb6/regb6.vhd
ghdl -e regb6
ghdl -a ../../regb6/tb.vhd
ghdl -e tb
ghdl -r tb --wave=tb.ghw

echo "[Message] Regb6 Built"

elif [ $componentNumber == "8" ]; then
echo "[Message] Building Regb16"
#BUILD REGB16 HERE

cd ./components/build/regb16

rm tb.ghw work-obj*

ghdl -a ../../regb16/regb16.vhd
ghdl -e regb16
ghdl -a ../../regb16/tb.vhd
ghdl -e tb
ghdl -r tb --wave=tb.ghw

echo "[Message] Regb16 Built"


fi

fi
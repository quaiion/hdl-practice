#!/bin/bash

deactivate || echo already deactivated
source ~/pyenvs/apicula-env/bin/activate

yosys -D LEDS_NR=0 -p "read_verilog -sv modules/SSeg_Translate.v modules/SSeg_Dig_Act.v modules/SSeg_Pt_Act.v modules/Gen_1ms.v modules/Mux_16_4.v modules/Display.v modules/top.v modules/rs232.v modules/URXD1B.v modules/UTXD1B.v modules/Sch_test_URXD1B.v ; synth_gowin -json artifacts/project.json"
nextpnr-himbaechel --json artifacts/project.json --write artifacts/pnr_project.json --device GW1NR-LV9QN88PC6/I5 --vopt family=GW1N-9C --vopt cst=project.cst
gowin_pack -d GW1N-9C -o artifacts/project.fs artifacts/pnr_project.json
openFPGALoader -b tangnano9k --detect artifacts/project.fs
openFPGALoader -b tangnano9k artifacts/project.fs

deactivate
echo done.

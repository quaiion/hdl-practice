#!/bin/bash

deactivate || echo already deactivated
source ~/pyenvs/apicula-env/bin/activate

yosys -D LEDS_NR=0 -p "read_verilog src/verilog/${HDL_PROJECT}/code.v; synth_gowin -json flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}.json"
nextpnr-himbaechel --json flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}.json --write flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_${HDL_PROJECT}.json --device GW1NR-LV9QN88PC6/I5 --vopt family=GW1N-9C --vopt cst=src/verilog/${HDL_PROJECT}/bind.cst
gowin_pack -d GW1N-9C -o flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}.fs flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_${HDL_PROJECT}.json
openFPGALoader -b tangnano9k --detect flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}.fs
openFPGALoader -b tangnano9k flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}.fs

deactivate
echo done.

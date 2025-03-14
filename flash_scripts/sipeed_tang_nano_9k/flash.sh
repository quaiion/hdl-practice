#!/bin/bash

deactivate || echo already deactivated
source ~/pyenvs/apicula-env/bin/activate

yosys -D LEDS_NR=0 -p "read_verilog src/verilog/${HDL_PROJECT}/${HDL_DEVICE}/device.v; synth_gowin -json flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}_${HDL_DEVICE}.json"
nextpnr-himbaechel --json flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}_${HDL_DEVICE}.json --write flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_${HDL_PROJECT}_${HDL_DEVICE}.json --device GW1NR-LV9QN88PC6/I5 --vopt family=GW1N-9C --vopt cst=src/verilog/${HDL_PROJECT}/${HDL_DEVICE}/bind.cst
gowin_pack -d GW1N-9C -o flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}_${HDL_DEVICE}.fs flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_${HDL_PROJECT}_${HDL_DEVICE}.json
openFPGALoader -b tangnano9k --detect flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}_${HDL_DEVICE}.fs
openFPGALoader -b tangnano9k flash_scripts/sipeed_tang_nano_9k/artifacts/${HDL_PROJECT}_${HDL_DEVICE}.fs

deactivate
echo done.

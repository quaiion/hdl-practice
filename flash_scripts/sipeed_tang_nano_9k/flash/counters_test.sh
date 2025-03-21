#!/bin/bash

deactivate || echo already deactivated
source ~/pyenvs/apicula-env/bin/activate

yosys -D LEDS_NR=0 -p "read_verilog src/verilog/counters/modules/Misc/Test.v ; synth_gowin -json flash_scripts/sipeed_tang_nano_9k/artifacts/counters.json"
nextpnr-himbaechel --json flash_scripts/sipeed_tang_nano_9k/artifacts/counters.json --write flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_counters.json --device GW1NR-LV9QN88PC6/I5 --vopt family=GW1N-9C --vopt cst=flash_scripts/sipeed_tang_nano_9k/bindings/counters_test.cst
gowin_pack -d GW1N-9C -o flash_scripts/sipeed_tang_nano_9k/artifacts/counters.fs flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_counters.json
openFPGALoader -b tangnano9k --detect flash_scripts/sipeed_tang_nano_9k/artifacts/counters.fs
openFPGALoader -b tangnano9k flash_scripts/sipeed_tang_nano_9k/artifacts/counters.fs

deactivate
echo done.

#!/bin/bash

deactivate || echo already deactivated
source ~/pyenvs/apicula-env/bin/activate

yosys -D LEDS_NR=0 -p "read_verilog src/verilog/couners/Device_1.v src/verilog/couners/Counters/VCB4CLED.v src/verilog/couners/Counters/VCB4RE.v src/verilog/couners/Counters/VCBD4SE.v src/verilog/couners/Counters/VCD4RE.v src/verilog/couners/Counters/VCG4RE.v src/verilog/couners/Counters/VCJ4RE.v src/verilog/couners/Display/Display.v src/verilog/couners/Display/submodules/7Seg_Dig_Act.v src/verilog/couners/Display/submodules/7Seg_Pt_Act.v src/verilog/couners/Display/submodules/7Seg_Translate.v src/verilog/couners/Display/submodules/Gen_1ms.v src/verilog/couners/Display/submodules/Mux_16_4.v src/verilog/couners/Misc/Debouncer.v ; synth_gowin -json flash_scripts/sipeed_tang_nano_9k/artifacts/counters.json"
nextpnr-himbaechel --json flash_scripts/sipeed_tang_nano_9k/artifacts/counters.json --write flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_counters.json --device GW1NR-LV9QN88PC6/I5 --vopt family=GW1N-9C --vopt cst=flash_scripts/sipeed_tang_nano_9k/bindings/counters_1.cst
gowin_pack -d GW1N-9C -o flash_scripts/sipeed_tang_nano_9k/artifacts/counters.fs flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_counters.json
openFPGALoader -b tangnano9k --detect flash_scripts/sipeed_tang_nano_9k/artifacts/counters.fs
openFPGALoader -b tangnano9k flash_scripts/sipeed_tang_nano_9k/artifacts/counters.fs

deactivate
echo done.

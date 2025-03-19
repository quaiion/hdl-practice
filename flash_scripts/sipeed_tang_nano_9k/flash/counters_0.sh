#!/bin/bash

deactivate || echo already deactivated
source ~/pyenvs/apicula-env/bin/activate

yosys -D LEDS_NR=0 -p "read_verilog src/verilog/counters/modules/Device_0.v src/verilog/counters/modules/Counters/VCB4CLED.v src/verilog/counters/modules/Counters/VCB4RE.v src/verilog/counters/modules/Counters/VCBD4SE.v src/verilog/counters/modules/Counters/VCD4RE.v src/verilog/counters/modules/Counters/VCG4RE.v src/verilog/counters/modules/Counters/VCJ4RE.v src/verilog/counters/modules/Display/Display.v src/verilog/counters/modules/Display/submodules/SSeg_Dig_Act.v src/verilog/counters/modules/Display/submodules/SSeg_Pt_Act.v src/verilog/counters/modules/Display/submodules/SSeg_Translate.v src/verilog/counters/modules/Display/submodules/Gen_1ms.v src/verilog/counters/modules/Display/submodules/Mux_16_4.v src/verilog/counters/modules/Misc/Gen_Nms_1s.v ; synth_gowin -json flash_scripts/sipeed_tang_nano_9k/artifacts/counters.json"
nextpnr-himbaechel --json flash_scripts/sipeed_tang_nano_9k/artifacts/counters.json --write flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_counters.json --device GW1NR-LV9QN88PC6/I5 --vopt family=GW1N-9C --vopt cst=flash_scripts/sipeed_tang_nano_9k/bindings/counters_0.cst
gowin_pack -d GW1N-9C -o flash_scripts/sipeed_tang_nano_9k/artifacts/counters.fs flash_scripts/sipeed_tang_nano_9k/artifacts/pnr_counters.json
openFPGALoader -b tangnano9k --detect flash_scripts/sipeed_tang_nano_9k/artifacts/counters.fs
openFPGALoader -b tangnano9k flash_scripts/sipeed_tang_nano_9k/artifacts/counters.fs

deactivate
echo done.

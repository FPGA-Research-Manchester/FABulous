#!/bin/bash
set -ex
#rm -f picorv32.v
#wget https://raw.githubusercontent.com/cliffordwolf/picorv32/master/picorv32.v
yosys picorv32.ys
set +e
../nextpnr-diko --json picorv32.json --fasm picorv32.fasm --pcf picorv32.pcf --freq 125
set -e

#!/bin/bash
set -ex
/usr/bin/time -v yosys simple.ys
/usr/bin/time -v nextpnr-diko --json simple.json --pcf simple.pcf --fasm simple.fasm  --freq 200 --verbose --debug

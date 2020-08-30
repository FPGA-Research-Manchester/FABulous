#!/bin/bash
set -ex
/usr/bin/time -v yosys template.ys
/usr/bin/time -v nextpnr-diko --json template.json --pcf template.pcf --fasm template.fasm  --freq 200 --verbose --debug

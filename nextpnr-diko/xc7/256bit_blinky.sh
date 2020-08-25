#!/bin/bash
set -ex
/usr/bin/time -v yosys 256bit_blinky.ys
/usr/bin/time -v ../nextpnr-xc7 --json blinky.json --pcf blinky.pcf --fasm blinky.fasm --freq 200

#!/bin/bash
set -ex
/usr/bin/time -v yosys blinky.ys
/usr/bin/time -v nextpnr-diko --json blinky.json --pcf blinky.pcf --fasm blinky.fasm --freq 200 --verbose

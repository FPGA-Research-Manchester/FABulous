set drc {LUTLP-1 NSTD-1 UCIO-1 PDRC-153 PLHOLDVIO-2}
set_property IS_ENABLED 0 [get_drc_checks $drc]
get_property IS_ENABLED [get_drc_checks $drc]
set_property BITSTREAM.GENERAL.CRC DISABLE [current_design]

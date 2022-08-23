load_fabric ./demo/fabric.csv
run_FABulous_fabric
# after load_fabric, all dir path will be relative to path of fabric.csv
run_FABulous_bitstream npnr ./user_design/sequential_16bit_en.v

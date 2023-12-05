clear -all
analyze -sv09 z_1_2_checker.sv bind.sv
analyze -vhdl z_1_2.vhd
# elaborate -top simple_example
elaborate -vhdl -top z_1_2
clock clk
reset rst
prove -bg -all

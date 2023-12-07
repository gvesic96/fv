clear -all
analyze -sv09 z3_all_checker.sv bind.sv
analyze -vhdl z3_all.vhd
elaborate -vhdl -top zadatak
clock clk
#reset -none
reset rst
prove -bg -all

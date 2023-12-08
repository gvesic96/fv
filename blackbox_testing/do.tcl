clear -all
analyze -sv09 blackbox_checker.sv bind.sv
analyze -sv09 sv_model.sv
elaborate -sv09 -top sv_model
clock clk
#reset -none
reset rst
prove -bg -all

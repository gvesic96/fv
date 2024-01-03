clear -all
analyze -sv09 tl_ctrl.sv check_tl_ctrl.sva bind.sva
elaborate -top {tl_ctrl}
clock clk
reset rst
prove -bg -all

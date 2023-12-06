clear -all
analyze -sv09 z2_2_checker.sv bind.sv
 
#analyze -vhdl {work::/nethome/stefan.despotovic1/Desktop/fv/vezbe1/part2/zadatak2/lut.vhd} ; 
#analyze -vhdl {work::/nethome/stefan.despotovic1/Desktop/fv/vezbe1/part2/zadatak2/zadatak2.vhd} ;
#analyze -vhdl {work zadatak2.vhd} {work lut.vhd}
# elaborate -top simple_example
elaborate -vhdl -top z2_2
clock clk
reset rst
prove -bg -all

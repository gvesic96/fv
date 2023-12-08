checker blackbox_checker (clk, rst, x, y);

	default
	clocking @(posedge clk);
	endclocking

	default disable iff rst;
		
	logic x_s;
	
	always @(posedge clk)
		x_s <= rst ? 1'b0 : x;
	

	assert property (y(0) |=> !y(0));
	assert property (s_eventually(y(2)) ##1 y[=2]);
	assert property (!y(4) |-> (y(1) ##1 y(3)));//vrati se posle na ovaj
	assert property ((y(2) ##1 y(5)) |=> y(6));
	assert property (!y(2)[*3] |-> y(7));
	
	assert property (y(8)[*2:3] ##1 !y(9) ##1 y(10));
	assert property (!(y(0) ##1 y(1)) |=> y(11));
	assert property (y(2)[->2] |=> y(16));
	//assert property (
/*
	assert property ((ENDD1 or RDY1 or START1) |-> rt1_s); // zadatak1	
	assert property (ER2 |-> ##[1:3] !ER2); //zadatak2
	assert property ((ER3 and RDY3) |=> !(ER3 & RDY3)); //zadatak3 
	assert property (RDY4 |-> start4_s); //zadatak4 
	assert property ((ENDD5 or STOP5 or ER5) |=> !RDY5); //zadatak5 
	assert property ((ENDD6 or STOP6 or ER6) |-> RDY6); //zadatak6 
	assert property (ENDD7 |-> !(START7 & STATUS_VALID7)); //zadatak7 
	assert property (RT8 |-> !ENABLE8); //zadatak8_1 
	assert property ($fell(RT8) |-> !ENABLE8[*2]); //zadatak8_2	
	assert property (($fell(RDY9) or $fell(START9)) |-> (INTERUPT9 | $fell(INTERUPT9))); //zadatak9
	assert property (REQ10 |-> ##5 ACK10); //zadatak10 
*/
endchecker











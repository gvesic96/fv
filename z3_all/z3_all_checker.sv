checker zadatak_checker (
    	clk,
	rst,
	//zadatak1:
    	RT1,
   	RDY1,
    	START1,
	ENDD1,
	//zadatak2:	
	ER2,
	//zadatak3:	
	ER3,	
	RDY3,
	//zadatak4:
	RDY4,
	START4,
	//zadatak5:
	ENDD5,
	STOP5,
	ER5,
	RDY5,
	START5,
	//zadatak6:
	ENDD6,
	STOP6,
	ER6,
	RDY6,
	//zadatak7:
	ENDD7,
	START7,
	STATUS_VALID7,
	INSTARTSV7,
	//zadatak8:
	RT8,
	ENABLE8,
	//zadatak9:
	RDY9,
	START9,
	INTERUPT9,
	//zadatak10:
	ACK10,
	REQ10
	);

	default
	clocking @(posedge clk);
	endclocking

	default disable iff rst;
		
	logic rt1_s, start4_s;

	always @(posedge clk) begin
		if(RT1 == 1'b0) begin
			rt1_s <= 1'b1;
		end
	end

	always @(posedge clk) begin
		if(START4 == 1'b1) begin
			start4_s <= 1'b1;
		end
	end

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

endchecker











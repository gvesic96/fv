module hanoi  #(parameter S = 4)
  ( input        clk,
    input        rst,
	input  [1:0] fr;
	
	input  [1:0] to);
	
    /*input        wolf,
    input        sheep,
    input        cab,
    output [3:0] state);*/
	
	//------------------- hardver za funkcionalnost --------------------------------------
    //PLAN 1 -> Tri cetvorobitna registra
	/*
	logic r0[S-1:0], r1[S-1:0], r2[S-1:0];
    always @ (posedge clk)
      if (rst)
        begin
	    r0 <= 4'b1111;
	    r1 <= 4'b0000;
	    r2 <= 4'b0000;
	    //t <= 1'b0;
	end
      else
        begin
	    //t <= ~ t;
		
		//skidam sa nulte kule
	    if (fr == '00' and to == '01') begin
	      r0 <= ~r0;
		  r1 <= ~r1;
		  end
	    if (fr == '00' and to == '10') begin
	      r0 <= ~ro;
		  r2 <= ~r2;
		  end
		  
		//skidam sa prve kule
	    if (fr == '01' and to == '00') begin
	      r1 <= ~r1;
		  r0 <= ~r0;
		  end
		if(fr == '01' and to == '10') begin
		  r1 <= ~r1;
		  r2 <= ~rs;
		  end;
		  
		//skidam sa druge kule
		if(fr == '10' and to == '00') begin
		  r2 <= ~r2;
		  r0 <= ~r0;
		  end
		if(fr == '10' and to == '01') begin
		  r2 <= ~r2;
		  r1 <= ~r1;
		end
		
	end
	*/

	//PLAN 2 -> Tri cetvorobitna registra koji se pune i prazne sa shift komandom
	logic r0[S-1:0], r1[S-1:0], r2[S-1:0];
    always @ (posedge clk)
      if (rst)
        begin
	    r0 <= 4'b1111;
	    r1 <= 4'b0000;
	    r2 <= 4'b0000;
	    //t <= 1'b0;
	end
      else
        begin
	    //t <= ~ t;
		
		//skidam sa nulte kule - shiftujem ulevo
	    if (fr == '00' && to == '01') begin
	      r0 << 1;//skinem sa nulte kule
		  r1 >> 1;//pomerim sadrzaj prve kule
		  r1 <= r1 | 4'b1000;//dodam 1 plocicu odozgo
		  end
	    if (fr == '00' && to == '10') begin
	      r0 << 1;
		  r2 >> 1;
		  r2 <= r2 | 4'b1000;
		  end
		  
		//skidam sa prve kule
	    if (fr == '01' && to == '00') begin
	      r1 << 1;
		  r0 >> 1;
		  r0 <= r0 | 4'b1000;
		  end
		if(fr == '01' && to == '10') begin
		  r1 << 1;
		  r2 >> 1;
		  r2 <= r2 | 4'b1000;
		  end;
		  
		//skidam sa druge kule
		if(fr == '10' && to == '00') begin
		  r2 << 1;
		  r0 >> 1;
		  r0 <= r0 | 4'b1000;
		  end
		if(fr == '10' && to == '01') begin
		  r2 << 1;
		  r1 >> 1;
		  r1 <= r1 | 4'b1000;
		end
		
	end


	//----------------- odavde je na dalje je vezano za FPV alat ---------------------------

    assign state = {t, w, s, c};
    wire [2:0] in3 = {wolf, sheep, cab};

    default clocking
        @(posedge clk);
    endclocking

    default disable iff (rst);

    assume_valid_input :
      assume property ((in3 == 3'b000) | (in3 == 3'b001) |
                       (in3 == 3'b010) | (in3 == 3'b100));

    assume_wolf_sheep :
      restrict property (~((t & ~w & ~s) | (~t & w & s)));

    assume_sheep_cab :
      restrict property (~((t & ~s & ~c) | (~t & s & c)));

        property same_side(a, b, c);
            a |-> (b == c);
        endproperty

    assume_ss_cab :
      restrict property (same_side(cab, c, t));

    assume_ss_wolf :
      restrict property (same_side(wolf, w, t));

    assume_ss_sheep :
      restrict property (same_side(sheep, s, t));

    cov_main: cover property (state == 4'b1111);
endmodule

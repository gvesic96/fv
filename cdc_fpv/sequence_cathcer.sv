module sequence_cathcer
  (
   input logic clk,
   input logic rst,
   input logic start,
   input logic en,
   //input logic [2:0] ryg,

	//ulazi ovog bloka ujedno izlazi prethodnog
	//input logic red;
	//input logic yellow;
	//input logic green;

	input logic tracked_signal;//YELLOW - povezati tracked_signal na yellow u TOP modulu

	//izlaz sequence_checker bloka koji se aktivira kada se ulovi sekvenca 101
	output logic match;
   //output logic red,
   //output logic yellow,
   //output logic green
   );

    enum        {IDLE, STATE_0, STATE_1, STATE_2, STATE_3} state_reg, state_next;

	//modelovanje registra
	always_ff @(posedge clk)
	  begin
		if (rst)
            state <= IDLE;
		
		if(start & en)
			state_reg <= state_next;	  
	  end


    always_ff @(posedge clk)//koristi se za sekvencijalnu logiku
      begin
		//fsm
          case(state_reg)
			IDLE: begin
					match <= 1'b0;
					if(start & en)
						state_next <= STATE_0;
					
				  end
			
			STATE_0: begin
						match <= 1'b0;
						if(tracked_signal)
							state_next <= STATE_1;
						else
							state_next <= STATE_0;			
					 end
					 
			STATE_1: begin
						match <= 1'b0;
						if(tracked_signal)
							state_next <= STATE_1;
						else
							state_next <= STATE_2;
					 end
			
			STATE_2: begin
						match <= 1'b0;
						if(tracked_signal)
							state_next <= STATE_3;
						else
							state_next <= STATE_0;
					 end
			
			STATE_3: begin
						match <= 1'b1;
						if(tracked_signal)
							state_next <= STATE_1;
						else
							state_next <= STATE_2;
					 end
			
			default: begin
						state_next <= IDLE;
					 end

      end



endmodule

//Inkludujem blokove

`include "tl_ctrl.sv"
`include "sequence_catcher.sv"

module top_module
  (
   input logic clk_1,
   input logic clk_2;
   input logic rst,
   input logic start,
   input logic en,
   input logic [2:0] ryg,
   output logic result;

	//top modul nema izlaze
   );

    //enum        {IDLE, RED, RED_YELLOW, GREEN, YELLOW} state;

	//medjusignali za povezivanje
	wire r_out, y_out, g_out;
	wire match_out;
	
	//instanciran modul semafora
	tl_ctrl traffic_light_1 (.clk(clk_1),
							.rst(rst),
							.start(start),
							.en(en),
							.ryg(ryg),
							.red(r_out),
							.yellow(y_out),
							.green(g_out)
							);
	//instanciran modul sequence_catcher
	sequnce_catcher seq_catch_1 (.clk(clk_2),
							.rst(rst),
							.start(start),
							.en(en),
							.tracked_signal(y_out),
							.match(match_out)
							);

	//rezultat na izlazu prikazan kroz flop
	always_ff @(posedge clk_1)
	begin
		result <= match_out;
	end


endmodule


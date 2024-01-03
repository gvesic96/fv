module tl_ctrl
  (
   input logic clk,
   input logic rst,
   input logic start,
   input logic en,
   input logic [2:0] ryg,

	//ovo su izlazi bloka koji ce mi biti ulazi u drugi blok
   output logic red,
   output logic yellow,
   output logic green
   );

    enum        {IDLE, RED, RED_YELLOW, GREEN, YELLOW} state;

    always_ff @(posedge clk)//koristi se za sekvencijalnu logiku
      begin
          case (state)
              IDLE: begin
                  if (start & en)
                    case (ryg)
                        3'b100: begin
                            state <= RED;
                        end
                        3'b010: begin
                            state <= YELLOW;
                        end
                        3'b001: begin
                            state <= GREEN;
                        end
                        3'b110: begin
                            state <= RED_YELLOW;
                        end
                        default: begin
                            state <= IDLE;
                        end
                    endcase

              end
              RED: begin
                  if (en) state <= RED_YELLOW;
              end
              RED_YELLOW: begin
                  if (en) state <= GREEN;
              end
              GREEN: begin
                  if (en) state <= YELLOW;
              end
              YELLOW: begin
                  if (en) state <= RED;
              end
          endcase


          if (rst)
            state <= IDLE;

      end

    always_comb //koristi se za kombinacionu logiku
      begin
          green = 1'b0;
          yellow = 1'b0;
          red = 1'b0;
          case (state)
              IDLE: begin

              end
              RED: begin
                  red = 1'b1;
              end
              RED_YELLOW: begin
                  red = 1'b1;
                  yellow = 1'b1;
              end
              GREEN: begin
                  green = 1'b1;
              end
              YELLOW: begin
                  yellow = 1'b1;
              end
          endcase
      end

endmodule

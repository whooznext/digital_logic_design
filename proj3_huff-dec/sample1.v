module huffman_decoder (input x, output [2:0] y, input clk, input reset);

reg [2:0] state;
reg [2:0] pstate;
reg px;

parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

always @ (posedge clk or posedge reset)
	begin
		if (reset) 
			begin
				state <= S0;
				pstate <= S0;
				px = 1'b1; // y becomes 3'b000 if pstate=S0 and px=1
			end
		else case (state)
			S0: if (x) state <= S1; else state <= S0;
			S1: if (x) state <= S3; else state <= S2;
			S2: if (x) state <= S0; else state <= S0;
			S3: if (x) state <= S0; else state <= S4;
			S4: if (x) state <= S0; else state <= S0;
		endcase

		if (state) pstate <= state;
		else pstate <= S0;

		if (~reset & (x == 1 | x == 0)) px <= x;
		else px = 1'b1;
	end

assign y[2] = (~pstate[2] & pstate[1] & pstate[0] & px) | (pstate[2] & ~pstate[1] & ~pstate[0]);
assign y[1] = (pstate[2] & ~pstate[1] & ~pstate[0] & ~px) | (~pstate[2] & pstate[1] & ~pstate[0]);
assign y[0] = (pstate[2] & ~pstate[1] & ~pstate[0] & px) | (~pstate[2] & ~pstate[0] & ~px);

endmodule
module huffman_decoder(y, x, clk, reset);

	input x;
	input clk;
	input reset;
	output wire [2:0] y;
	
	parameter size = 4;
	parameter S_first = 4'b1000, 
	S0 = 4'b0001, 
	S1 = 4'b1001,
	S10 = 4'b1010,
	S100 = 4'b0011,
	S101 = 4'b0010,
	S11 = 4'b1011,
	S110 = 4'b1100,
	S111 = 4'b0100,
	S1101 = 4'b0101,
	S1100 = 4'b0110;
	
	reg [size-1:0] state;
	
	always @ (posedge clk or posedge reset)
	begin
		if (reset == 1)
		state <= S_first;
		
		else case (state)
		S_first: if (x) state <= S1; else state <= S0;
		S0: if (x) state <= S1; else state <= S0;
		S1: if (x) state <= S11; else state <= S10;
		S10: if (x) state <= S101; else state <= S100;
		S100: if (x) state <= S1; else state <= S0;
		S101: if (x) state <= S1; else state <= S0;
		S11: if (x) state <= S111; else state <= S110;
		S110: if (x) state <= S1101; else state <= S1100;
		S111: if (x) state <= S1; else state <= S0;
		S1101: if (x) state <= S1; else state <= S0;
		S1100: if (x) state <= S1; else state <= S0;
		endcase
	end
	

	assign y[2] = ~state[3]&state[2];
	assign y[1] = ~state[3]&state[1];
	assign y[0] = ~state[3]&state[0];
	
endmodule
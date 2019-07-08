module huffman_decoder (
	output [2:0] y,
	input x,
	input clk,
	input reset
);
reg [3:0] state;

parameter S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3 = 4'b0011, S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, S8 = 4'b1000, S9 = 4'b1001, S10 = 4'b1010;

always@ (posedge clk or posedge reset)
if (reset == 1) state <= S0;
else case (state)
S0: if(x) state <= S2; else state <= S1;
S1: if(x) state <= S2; else state <= S1;
S2: if(x) state <= S6; else state <= S3;
S3: if(x) state <= S4; else state <= S5;
S4: if(x) state <= S2; else state <= S1;
S5: if(x) state <= S2; else state <= S1;
S6: if(x) state <= S7; else state <= S8;
S7: if(x) state <= S2; else state <= S1;
S8: if(x) state <= S9; else state <= S10;
S9: if(x) state <= S2; else state <= S1;
S10: if(x) state <= S2; else state <= S1;
default: state <= S0;
endcase

assign y[2] = (state[2]&state[1]&state[0]) | (state[3]&state[0]) | (state[3]&state[1]);
assign y[1] = (state[2]&(~state[1])) | (state[3]&state[1]);
assign y[0] = (~state[1])&state[0];
endmodule
module Dflipflp(input d, output reg q, input clk, input reset);


always @ (posedge clk or posedge reset) begin
 if (reset) q <= 1'b0;
 else q <= d;
end

endmodule

module huffman_decoder(output wire [2:0] y, input x, input clk, input reset);

reg[2:0] state;
reg re;
wire a,b,c;
wire X;

parameter S0 = 3'b000;
parameter S1 = 3'b001;
parameter S2 = 3'b010;
parameter S3 = 3'b011;
parameter S4 = 3'b100;

Dflipflp D_X(x,X,clk,reset);
Dflipflp D_A(state[2],a,clk,reset);
Dflipflp D_B(state[1],b,clk,reset);
Dflipflp D_C(state[0],c,clk,reset);

always @ (posedge clk or posedge reset) begin
	if (reset == 1) 
	begin state = S0; re = 1; end
	else begin
		re = 0;
		case (state)
			S0: if (x) state <= S1; else state <= S0;
			S1: if (x) state <= S3; else state <= S2;
			S2: state <= S0;
			S3: if (x) state <= S0; else state <= S4;
			S4: state <= S0;
		endcase
	end
end

assign y[0] = ~re & (( ~a & ~c & ~X) | (a & X));
assign y[1] = ~re & (( b & ~c ) | (a & ~X));
assign y[2] = ~re & (a | ( b & c & X));

endmodule
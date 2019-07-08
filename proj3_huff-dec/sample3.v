
module huffman_decoder(y, x, clk, reset);

	input x;
	output reg[2:0] y;
	input clk;
	input reset;
	
	reg[2:0] state;
	
	parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
	
	always @ (posedge clk)
	if(reset == 1) begin state = S0; y = 3'b000; end
	else 	
	begin
		case(state)
		S0: if(x == 0) begin state = S0; y = 3'b001; end else begin state = S1; y = 3'b000; end
		S1: if(x == 0)	begin state = S2; y = 3'b000; end else begin state = S3; y = 3'b000; end
		S2: if(x == 0) begin state = S0; y = 3'b011; end else begin state = S0; y = 3'b010; end
		S3: if(x == 0) begin state = S4; y = 3'b000; end else begin state = S0; y = 3'b100; end
		S4: if(x == 0) begin state = S0; y = 3'b110; end else begin state = S0; y = 3'b101; end
		default: begin state = S0; y = 3'b000; end
		endcase
	end
	
endmodule
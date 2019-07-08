
module huffman_decoder(x, y, clk, reset);

	input x;
	output [2:0] y;
	input clk;
	input reset;
	
	reg [2:0] state;
	reg [2:0] y_value;
	
	assign y = y_value;
	
	always @ (posedge clk or posedge reset)
	begin
		if(y_value)
			y_value <= 3'b000;
		if(reset)
			y_value <= 3'b000;
		else
			if(state == 3'b000)
				if(x == 0)
					 y_value <= 3'b001;
				else
					state <= 3'b001;
			else if(state == 3'b001)
				if(x == 0)
					state <= 3'b010;
				else
					state <= 3'b011;
			else if(state == 3'b010)
				if(x == 0)
					y_value <= 3'b011;
				else
					y_value <= 3'b010;
			else if(state == 3'b011)
				if(x == 0)
					state <= 3'b110;
				else
					y_value <= 3'b100;
			else
				if(x == 0)
					y_value <= 3'b110;
				else
					y_value <= 3'b101;
	end
	
	always @(*)
	begin
	if(y_value)
			state <= 3'b000;
	end
	
	
endmodule
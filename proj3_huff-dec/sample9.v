module flipflop(a, b, clk, reset);
    input b, clk, reset;
    output reg a;
    always @(posedge clk or posedge reset)
    begin
        if(reset)
            a <= 1'b0;
        else
            a <= b;
    end
endmodule

module huffman_decoder(x, y, clk, reset);
	input x, clk, reset;
    output[2:0] y;
    wire[2:0] current;
    wire[2:0] next;
    wire[2:0] next2;

    flipflop first(.a(current[0]), .b(next[0]), .clk(clk), .reset(reset));
	flipflop second(.a(current[1]), .b(next[1]), .clk(clk), .reset(reset));
    flipflop third(.a(current[2]), .b(next[2]), .clk(clk), .reset(reset));
    flipflop forth(.a(y[0]), .b(next2[0]), .clk(clk), .reset(reset));
    flipflop fifth(.a(y[1]), .b(next2[1]), .clk(clk), .reset(reset));
    flipflop sixth(.a(y[2]), .b(next2[2]), .clk(clk), .reset(reset));

    assign next[0] = (~current[1])&(~current[2])&x;
    assign next[1] = current[0]&(~current[1])&(~current[2]);
	assign next[2] = current[0]&current[1]&(~current[2])&(~x);
    assign next2[0] = ((~current[0])&(~current[2])&(~x)) | ((~current[0])&(~current[1])&current[2]&x);
	assign next2[1] = ((~current[0])&(~current[1])&current[2]&(~x)) | ((~current[0])&current[1]&(~current[2]));
	assign next2[2] = ((~current[0])&(~current[1])&current[2]) | (current[0]&(current[1])&(~current[2])&x);
endmodule
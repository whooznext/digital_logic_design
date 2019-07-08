module dff(q, d, clock, reset);
    input d, clock, reset;
    output reg q;

    always @(posedge clock or posedge reset)
    begin
        if(reset)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule

module huffman_decoder(
    input x,
    output [2:0] y,
    input clk,
    input reset);

    wire [2:0] present;
    wire [2:0] next;
    wire [2:0] y_next;

    dff d1(.q(present[0]), .d(next[0]), .clock(clk), .reset(reset));
    dff d2(.q(present[1]), .d(next[1]), .clock(clk), .reset(reset));
    dff d3(.q(present[2]), .d(next[2]), .clock(clk), .reset(reset));
    dff d4(.q(y[0]), .d(y_next[0]), .clock(clk), .reset(reset));
    dff d5(.q(y[1]), .d(y_next[1]), .clock(clk), .reset(reset));
    dff d6(.q(y[2]), .d(y_next[2]), .clock(clk), .reset(reset));

    assign next[2] = (~present[2])&(present[1])&(present[0])&(~x);
    assign next[1] = (~present[2])&(~present[1])&(present[0]);
    assign next[0] = (~present[2])&(~present[1])&x;

    assign y_next[2] = ((present[2])&(~present[1])&(~present[0])) | ((~present[2])&(present[1])&(present[0])&x);
    assign y_next[1] = ((~present[2])&(present[1])&(~present[0])) | ((present[2])&(~present[1])&(~present[0])&(~x));
    assign y_next[0] = ((~present[2])&(~present[0])&(~x)) | (present[2]&(~present[1])&(~present[0])&x);

endmodule
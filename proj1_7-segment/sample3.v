module num_7seg_B(out, w, x, y, z);

input w, x, y, z;
output out;

wire w;
wire x;
wire y; 
wire z;
wire out;

assign out = (~y&~z)|(x&~z)|(x&~y)|w;

endmodule

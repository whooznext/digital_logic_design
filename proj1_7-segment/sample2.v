
module num_7seg_B(out,w,x,y,z);

input w, x, y, z;
output out;

wire x, y, z, w;
wire out;

assign out = ~y&~z | x&~y | x&~z | w;

endmodule
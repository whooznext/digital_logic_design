
module num_7seg_B(out,w,x,y,z);

input w,x,y,z;
output out;
wire w,x,y,z,out;

assign out = w|((~y)&(~z))|x&(~z)|x&(~y);

endmodule


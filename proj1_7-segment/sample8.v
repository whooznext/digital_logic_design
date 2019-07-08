module num_7seg_B(out,w,x,y,z);

output out;
input w,x,y,z;

assign out=w|x&~y|x&~z|~y&~z;

endmodule
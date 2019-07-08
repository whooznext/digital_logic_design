//module num_7seg_B SEG_B;
module num_7seg_B(out,w,x,y,z);
//SEG_B(out,w,x,y,z);

input w, x, y, z;
output out;
wire f1, f2, f3;

and (f1, x, ~z);
and (f2, ~y, ~z);
and (f3, x, ~y);

assign out = w | f1 | f2 | f3;

endmodule
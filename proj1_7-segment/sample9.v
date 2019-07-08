module num_7seg_B(output out,input w,x,y,z);

assign out =((~y) & (~z)) |( w )|( x&(~z)) |( x&(~y)) ; 


endmodule

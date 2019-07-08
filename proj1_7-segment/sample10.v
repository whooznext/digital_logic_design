module num_7seg_B(out ,w, x, y, z); 
output out; reg out; 
input w, x, y, z;

    always @(*)
    begin
        out = w | (~y&~z) | (x&~y) | (x&~z);
    end

endmodule

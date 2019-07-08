module calCarry(a, b, C0, carry);
input a,b,C0;
output carry;
    assign carry=b|(a&C0);
endmodule

module add_or_sub(a, b, m, x, y);
input a, b, m;
output x, y;
    assign x=a^(b^m);
    assign y=a&(b^m);
endmodule


module calsum(p, carry, s);
input p; 
input carry;
output s;
    assign s=p^carry;
endmodule

module cla_gen(P, G, C0, C) ;  
parameter W=4;
input [W-1:0] P, G;
input C0;
output [W:0] C;

assign C[0]=C0;

genvar i;
generate
    for(i=0;i<W;i=i+1)
    begin : cla_gen_in 
        calCarry gc(.a(P[i]), .b(G[i]), .C0(C[i]), .carry(C[i+1]));
    end
endgenerate

endmodule

module addsub_cla(A, B, S, C, M, V);
parameter W=4;
input [W-1:0] A, B;
input M;
output [W-1:0] S;
output C;
output V;


wire [W-1:0] P;
wire [W-1:0] G;
wire [W:0] Carry;



genvar j;
generate
    for(j=0;j<W;j=j+1)
    begin : arr_pg
        add_or_sub pg(.a(A[j]), .b(B[j]), .m(M), .x(P[j]), .y(G[j]));
    end
endgenerate

cla_gen #(.W(W)) CLAGEN(.P (P),.G (G),.C0 (M),.C (Carry));

genvar k;
generate
    for(k=0;k<W;k=k+1)
    begin : arr_s 
            calsum gs(.p(P[k]), .carry(Carry[k]), .s(S[k]));
    end
endgenerate

assign C=Carry[W];
assign V=Carry[W-1]^Carry[W];

endmodule
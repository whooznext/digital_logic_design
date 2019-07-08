module carry_gen(input Cin, 
                 input P, 
                 input G, 
                 output Cout);

assign Cout = G | (P&Cin);

endmodule

module cla_gen(C0, P, G, C);
parameter W = 4;
input C0;
input [W-1:0] P;
input [W-1:0] G;
output wire [W:0] C;

assign C[0] = C0;

genvar i;
generate
    for(i = 1; i <= W; i = i + 1)
    begin: gen_carry
        carry_gen cgen(C[i-1], P[i-1], G[i-1], C[i]);
    end
endgenerate

endmodule

module addsub_cla(A, B, M, S, C, V);
parameter W = 4;
input [W-1:0] A;
input [W-1:0] B;
input M;
output [W-1:0] S;
output C, V;

wire [W-1:0] B2;
wire [W:0] Cs;

assign B2 = B^{(W){M}};

cla_gen #(.W(W)) CLAGEN(M, A^B2, A&B2, Cs);

assign S = (A ^ B2) ^ Cs[W-1:0];
assign C = Cs[W];
assign V = Cs[W] ^ Cs[W-1];
endmodule
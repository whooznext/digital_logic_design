module addsub_cla(A, B, S, C, M, V);
parameter W=8;

input [W-1:0] B;
input [W-1:0] A;
output [W-1:0] S;
output C;
input M;
output V;

wire [W-1:0] P, G;
wire [W:0] c;

assign C = c[W];
assign V = c[W]^c[W-1];
assign S = P^c[W-1:0];

cla_gen #(.W(W)) CLAGEN(.P(P), .G(G), .C0(M), .C(c));

genvar i;
generate
    for(i=0; i<W; i=i+1)
    begin: cla_gen_in
        ha HA( .x(A[i]), .y(B[i]^M), .s(P[i]), .c(G[i]) );
    end
endgenerate

endmodule



module cla_gen(P, G, C0, C);
parameter W=8;

input [W-1:0] P;
input [W-1:0] G;
input C0;
output [W:0] C;

wire [W:0] C;
assign C[0] = C0;

genvar i;
for(i=0; i<W; i=i+1)
begin
    assign C[i+1] = G[i] | (P[i]&C[i]);
end
endmodule



module ha(x, y, s, c);
input x, y;
output s, c;

assign s = x^y;
assign c = x&y;
endmodule
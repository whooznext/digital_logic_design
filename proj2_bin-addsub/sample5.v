module cla_gen(P,G,C0,C);

parameter W = 4;

input [W-1:0]P, G;
input C0;
output [W:0]C;
assign C[0] = C0;

genvar i;
generate
	for(i = 0; i<W; i = i+1) begin
	assign C[i+1] = G[i] + P[i]*C[i]; 
	end

endgenerate


endmodule



module addsub_cla(A,B,S,C,M,V);
parameter W = 4;

input [W-1:0] A, B;
output [W-1:0] S;
output C; // 1bit (MSB)
input M;
output V; // C[W] ^ C[W-1]


wire [W-1:0] P,G,S;
wire [W:0] PC;

genvar i;

generate 
	for(i = 0; i<W; i = i+1) begin
	assign P[i] = A[i]^(M^B[i]);
	assign G[i] = A[i]*(M^B[i]); 
	assign S[i] = P[i]^PC[i]; 
	end
endgenerate


cla_gen # (.W(W)) CLAGEN(.P(P), .G(G), .C0(M), .C(PC));

assign V = PC[W-1] ^ PC[W];
assign C = PC[W];
endmodule

module addsub_cla(S,C,V, A,B,M);

parameter W=4;


output [W-1:0] S;
output C, V;
input [W-1:0] A,B;
input M;

wire [W:0] c;

assign c[0] = M;

reg [W-1:0] Bp;
always @(*) begin
if(M==0)
Bp = B[W-1:0];
else
Bp = ~B[W-1:0];
end

cla_gen #(.W(W)) CLAGEN(.C(c), .P(A^Bp), .G(A&Bp), .C0(M));// carry


genvar i;

generate
	for(i=0;i<W;i=i+1)
	begin:result
		assign S[i] = A[i]^Bp[i]^c[i];
	end
endgenerate


assign C= c[W];



assign V = (c[W] != c[W-1]) ? 1'b1:1'b0;


endmodule

module cla_gen(C,P,G,C0);

parameter W =4;

output reg [W:0] C;

input [W-1:0] P;
input [W-1:0] G;
input C0;

integer i;

always @(*) begin
	C[0]=C0;
	for (i =0; i<W; i=i+1) begin
		C[i+1] = G[i] | (P[i]&C[i]);
	end
end


endmodule

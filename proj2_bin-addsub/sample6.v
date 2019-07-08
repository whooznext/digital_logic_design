

module addsub_cla(A, B, S, C, M, V);
	parameter W=4;
	
	input signed [W-1:0] A;
	input signed [W-1:0] B;
	output signed [W-1:0] S;
	output C;
	input M;
	output V;
	
	wire [W-1:0] P;
	wire [W:0] Ci;
	wire [W-1:0] G;
	wire [W-1:0] BxorM;
	
	genvar i;
	generate
		for(i=0; i<W; i=i+1)
		begin
			assign BxorM[i] = B[i]^M;
		end
	endgenerate
	
	assign P[W-1:0] = BxorM[W-1:0]^A[W-1:0];
	assign G[W-1:0] = BxorM[W-1:0]&A[W-1:0];
	cla_gen #(.W(W)) CLAGEN(.P(P), .G(G), .C0(M), .C(Ci));
	
	assign S[W-1:0] = P[W-1:0]^Ci[W-1:0];
	assign V = Ci[W]^Ci[W-1];
	assign C = Ci[W];
		
endmodule

module cla_gen(P, G, C0, C);
	parameter W=4;
	
	input [W-1:0] P, G;
	input C0;
	output [W:0] C;
	
	assign C[0] = C0;
	assign C[W:1] = G[W-1:0]|(P[W-1:0]&C[W-1:0]);
	
endmodule



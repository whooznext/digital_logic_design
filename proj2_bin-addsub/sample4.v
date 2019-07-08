module addsub_cla(A,B,M,S,C,V);
	
	input [W-1:0] A;
	input [W-1:0] B;
	input M;
	output [W-1:0] S;
	output C;
	output V;
	
	parameter W = 4;
	
	wire[W-1:0] p;
	wire[W-1:0] g;
	wire[W:0] c;
	reg v;
	reg [W-1:0] Bb;
	
	always@(*)
	begin
	if(M==1)
		Bb[W-1:0] = ~B[W-1:0];
	else if(M==0)
		Bb[W-1:0] = B[W-1:0];
	end
	
	assign p[W-1:0] = A[W-1:0]^Bb[W-1:0];
	assign g[W-1:0] = A[W-1:0]&Bb[W-1:0];
	
	cla_gen #(.W(W)) CLAGEN(.P(p), .G(g), .C0(M), .C(c));
	
	always@(*)
	begin
		if(c[W] == c[W-1])
			v = 1'b0;
		else
			v = 1'b1;
	end
	
	assign V = v;
	
	genvar j;
		generate
			for(j=0;j<W;j=j+1)
				begin
					assign S[j] = c[j]^p[j];
				end
		endgenerate
	
	assign C = c[W];
	
	
	
endmodule


module cla_gen(P,G,C0,C);
	parameter W = 4;
	input [W-1:0] P;
	input [W-1:0] G;
	input C0;
	output [W:0] C;
	
	genvar i;
	generate
		for(i=1; i<W+1; i=i+1)
			begin
				assign C[i] = G[i-1] | (P[i-1]&C[i-1]);
			end
	endgenerate
	assign C[0] = C0;
endmodule
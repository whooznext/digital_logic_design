module addsub_cla 
#(parameter W=4)
	(
		input signed[W-1:0] A,
		input signed[W-1:0] B,
		output signed[W-1:0] S,
		output C,
		input M,
		output V
	);
	wire[W-1:0] m_B;
	wire[W-1:0] w_P;
	wire[W-1:0]	w_G;
	wire[W:0] cla_C;
	
	genvar i;
	generate
		for(i=0;i<W;i=i+1)
		begin
			assign m_B[i]=B[i]^M;
			assign w_P[i]=A[i]^m_B[i];
			assign w_G[i]=A[i]&m_B[i];
		end
	endgenerate

	cla_gen #(.W(W))CLAGEN(.P(w_P),.G(w_G),.C0(M),.C(cla_C));
	
	genvar j;
	generate
	for(j=0;j<W;j=j+1)
	begin
		assign S[j]=w_P[j]^cla_C[j];
	end
	endgenerate
	
	assign C=cla_C[W];
	assign V=cla_C[W]^cla_C[W-1];
	
endmodule

module cla_gen
	#(parameter W=4)
	(
		input[W-1:0] P,
		input[W-1:0] G,
		input C0,
		output[W:0]C
	);
	assign C[0]=C0;
	genvar l;
	generate
	for(l=1;l<W+1;l=l+1)
	begin
		assign C[l]=G[l-1]|(P[l-1]&C[l-1]);
	end
	endgenerate
endmodule



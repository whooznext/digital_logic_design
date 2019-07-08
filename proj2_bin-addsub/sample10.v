module addsub_cla #(
    parameter  W=4)(
    input [W-1:0] A,
    input [W-1:0] B,
    input M,
    
    output [W-1:0] S,
    output C,
    output V
    );
    
    wire [W-1:0] p;
    wire [W-1:0] g;
    wire [W:0] c;
    
    //P,G °ª °è»ê
    genvar i;
    generate
        for(i=0; i<W; i = i+1) 
        begin
            assign p[i] = A[i] ^ (B[i] ^ M);
            assign g[i] = A[i] & (B[i] ^ M);
        end
    endgenerate
    
    //Carry
    cla_gen #(.W(W)) CLAGEN(.P(p), .G(g), .C0(M), .C(c));
    
    assign C = c[W];
    
    //overflow
    assign V = c[W] ^ c[W-1];
    
    //sum
    generate
        for(i=0; i<W; i=i+1)
        begin
            assign S[i] = c[i] ^ p[i];
        end
    endgenerate
endmodule

module cla_gen #(
    parameter W=4)(
    input [W-1:0] P,
    input [W-1:0] G,
    input C0,
    output [W:0] C);
    
    assign C[0] = C0;
    
    genvar i;
    generate
        for(i=0; i<W; i =i+1) 
        begin
            assign C[i+1] = G[i] | P[i] & C[i];
        end
    endgenerate

endmodule

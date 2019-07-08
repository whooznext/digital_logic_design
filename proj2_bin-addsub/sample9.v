module addsub_cla (A, B, S, C, M, V);
   parameter W = 4;
   input [W-1:0] A, B;
   output [W-1:0] S;
   output C;
   input M;
   output V; 

   
   wire [W-1:0] b, p, g;
   wire [W:0] c;

   cla_gen #(.W(W)) CLAGEN (.P(p), .G(g), .C0(M), .C(c));

   genvar i;
   generate
      for(i=0; i<W; i=i+1)
      begin: CGI
         half_adder HA(.x(A[i]), .y(B[i]^M), .s(p[i]), .c(g[i]));
      end   
   endgenerate
   
   assign S = p^c;
   assign C = c[W];
   assign V = c[W-1]^c[W];
   
endmodule


module cla_gen (P, G, C0, C);
   parameter W = 4;
   input [W-1:0] P, G;
   input C0;
   output [W:0] C;
   
   assign C[0] = C0;
   
   genvar i;
   generate
      for(i=0; i<W; i=i+1) 
      begin: PG
         assign C[i+1] =  G[i] | (P[i]&C[i]);
      end
   endgenerate

endmodule
   

module half_adder(x, y, s, c);
   input x, y;
   output s, c;

   assign s = x^y;
   assign c = x&y;

endmodule
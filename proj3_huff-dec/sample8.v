module dff(d,q,clk,reset);
  input d,clk,reset;
  output q;
  reg q;

  always @(posedge clk or posedge reset)
	if(reset)
		q<=1'b0;
	else
		q<=d;
endmodule

module huffman_decoder(x,y,clk,reset);
  input x,clk,reset;
  output [2:0]y;
  
  wire [3:1]S;
  wire [3:1]d;
  wire [2:0]Y;
  
  assign d[3]=(x&~S[2]&~S[3]&~S[1])|(~x&~S[2]&S[3]);
  assign d[2]=~S[2]&S[3];
  assign d[1]=~x&S[2]&~S[3];
  assign Y[2]=S[1]|(x&S[2]&~S[3]);
  assign Y[1]=(S[1]&~x)|(S[2]&S[3]);
  assign Y[0]=(S[1]&x)|(S[2]&S[3]&~x)|(~S[2]&~x&~S[3]&~S[1]);
  
  dff d3(.d(d[3]),.q(S[3]),.clk(clk),.reset(reset));
  dff d2(.d(d[2]),.q(S[2]),.clk(clk),.reset(reset));
  dff d1(.d(d[1]),.q(S[1]),.clk(clk),.reset(reset));
  dff dy2(.d(Y[2]),.q(y[2]),.clk(clk),.reset(reset));
  dff dy1(.d(Y[1]),.q(y[1]),.clk(clk),.reset(reset));
  dff dy0(.d(Y[0]),.q(y[0]),.clk(clk),.reset(reset));
endmodule
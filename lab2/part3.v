module hex_decoder(c, display);

	input [0:3] c;
	wire [0:3] d;
	assign d[0] = c[3];
	assign d[1] = c[2];
	assign d[2] = c[1];
	assign d[3] = c[0];
	output [0:6] display;
	
	eqn0 e0(d, display[6]); 
	eqn1 e1(d, display[5]); 
	eqn2 e2(d, display[4]); 
	eqn3 e3(d, display[3]); 
	eqn4 e4(d, display[2]); 
	eqn5 e5(d, display[1]); 
	eqn6 e6(d, display[0]); 

endmodule



module eqn0(c, out);
	
	input [0:3] c;
	output out;
	assign out = ~((c[3]|c[2]|c[1]|~c[0]) & (c[3]|~c[2]|c[1]|c[0]) & (~c[3]|c[2]|~c[1]|~c[0]) & (~c[3]|~c[2]|c[1]|~c[0]));

endmodule


module eqn1(c, out);
	
	input [0:3] c;
	output out;
	assign out = ~((c[3]|~c[2]|c[1]|~c[0]) & (c[3]|~c[2]|~c[1]|c[0]) & (~c[3]|c[2]|~c[1]|~c[0]) & (~c[3]|~c[2]|c[1]|c[0]) & (~c[3]|~c[2]|~c[1]|c[0]) & (~c[3]|~c[2]|~c[1]|~c[0]));

endmodule


module eqn2(c, out);
	
	input [0:3] c;
	output out;
	assign out = ~((c[3]|c[2]|~c[1]|c[0]) & (~c[3]|~c[2]|c[1]|c[0]) & (~c[3]|~c[2]|~c[1]|c[0]) & (~c[3]|~c[2]|~c[1]|~c[0]));

endmodule


module eqn3(c, out);
	
	input [0:3] c;
	output out;
	assign out = ~((c[3]|c[2]|c[1]|~c[0]) & (c[3]|~c[2]|c[1]|c[0]) & (c[3]|~c[2]|~c[1]|~c[0]) & (~c[3]|c[2]|~c[1]|c[0]) & (~c[3]|~c[2]|~c[1]|~c[0]));

endmodule


module eqn4(c, out);
	
	input [0:3] c;
	output out;
	assign out = ~((c[3]|c[2]|c[1]|~c[0]) & (c[3]|c[2]|~c[1]|~c[0]) & (c[3]|~c[2]|c[1]|c[0]) & (c[3]|~c[2]|c[1]|~c[0]) & (c[3]|~c[2]|~c[1]|~c[0]) & (~c[3]|c[2]|c[1]|~c[0]));

endmodule


module eqn5(c, out);
	
	input [0:3] c;
	output out;
	assign out = ~((c[3]|c[2]|c[1]|~c[0]) & (c[3]|c[2]|~c[1]|c[0]) & (c[3]|c[2]|~c[1]|~c[0]) & (c[3]|~c[2]|~c[1]|~c[0]) & (~c[3]|~c[2]|c[1]|~c[0]));

endmodule


module eqn6(c, out);
	
	input [0:3] c;
	output out;
	assign out = ~((c[3]|c[2]|c[1]|c[0]) & (c[3]|c[2]|c[1]|~c[0]) & (c[3]|~c[2]|~c[1]|~c[0]) & (~c[3]|~c[2]|c[1]|c[0]));

endmodule


module part2 (a, b, c_in, s, c_out);
	input c_in;
	input [3:0] a;
	input [3:0] b;
	output [3:0] s;
	output [3:0] c_out;

	full_adder u0(a[0], b[0], c_in, s[0], c_out[0]);
	full_adder u1(a[1], b[1], c_out[0], s[1], c_out[1]);
	full_adder u2(a[2], b[2], c_out[1], s[2], c_out[2]);
	full_adder u3(a[3], b[3], c_out[2], s[3], c_out[3]);
endmodule 

module full_adder (a, b, c_in, s, c_out);
	input a, b, c_in;
	output c_out, s;
	
	assign s	= a^b^c_in;
	assign c_out = (a & b)|(a & c_in)|(b & c_in);
endmodule

module part3(A, B, Function, ALUout);
	input [3:0] A, B;
	input [2:0] Function;
	output reg [7:0] ALUout;
	wire [3:0] case0_c;
	wire [3:0] case0_s;
	
	FBRCAC adder0(A, B, 1'b0, case0_s, case0_c);
	
	
	always @(Function, A, B)
	begin
		case (Function)
			3'b000: ALUout = {3'b000, case0_c[3], case0_s};
			3'b001: ALUout = A + B;
			3'b010: ALUout = {B[3], B[3], B[3], B[3], B};
			3'b011: ALUout = A[0]|A[1]|A[2]|A[3]|B[0]|B[1]|B[2]|B[3] ? 8'b00000001 : 8'b00000000;
			3'b100: ALUout = A[0]&A[1]&A[2]&A[3]&B[0]&B[1]&B[2]&B[3] ? 8'b00000001 : 8'b00000000;
			3'b101: ALUout = {A, B};
			default: ALUout = 8'b00000000;
		endcase
	end
	
endmodule

module FBRCAC (a, b, c_in, s, c_out);
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

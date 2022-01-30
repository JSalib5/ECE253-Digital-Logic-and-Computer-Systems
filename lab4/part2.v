module part2(Clock, Reset_b, Data, Function, ALUout);
	input Clock;
	input Reset_b;
	input [3:0] Data;
	input [2:0] Function;
	output reg [7:0] ALUout;
	reg [7:0] ALUhold;
	wire [4:0] FBRCAC_out;
	FBRCAC adder(
		.a(Data),
		.b(ALUout[3:0]),
		.s(FBRCAC_out[3:0]),
		.c_out(FBRCAC_out[4])
	);

	// ALU Circuit
	// Inputs:
	//		ALUout
	//		Data
	//		Function
	// Outputs:
	//		ALUhold
	always @(*)
	begin
		case(Function)
			3'b000: ALUhold = FBRCAC_out;
			3'b001: ALUhold = Data + ALUout[3:0];
			3'b010: ALUhold = {ALUout[3], ALUout[3], ALUout[3], ALUout[3], ALUout[3:0]};
			3'b011: ALUhold = Data[0]|Data[1]|Data[2]|Data[3]|ALUout[0]|ALUout[1]|ALUout[2]|ALUout[3] ? 8'b00000001 : 8'b00000000;
			3'b100: ALUhold = Data[0]&Data[1]&Data[2]&Data[3]&ALUout[0]&ALUout[1]&ALUout[2]&ALUout[3] ? 8'b00000001 : 8'b00000000;
			3'b101: ALUhold = ALUout[3:0] << Data;
			3'b110: ALUhold = Data * ALUout[3:0];
			3'b111: ALUhold = ALUout;
			default: ALUhold = 8'b00000000;
		endcase
	end
	
	// Register Circuit
	// Inputs:
	//		ALU_out
	//		Reset_b
	// Outputs:
	//		reg_out
	always @(posedge Clock)
	begin
	if (Reset_b == 1'b0)
		ALUout <= 8'b00000000;
	else
		ALUout <= ALUhold;
	end

endmodule

module FBRCAC (a, b, s, c_out);
	input [3:0] a;
	input [3:0] b;
	output [3:0] s;
	output c_out;
	wire c[3:0];
	assign c[0] = 1'b0;

	FA u0(.a(a[0]), .b(b[0]), .c_in(c[0]), .s(s[0]), .c_out(c[1]));
	FA u1(.a(a[1]), .b(b[1]), .c_in(c[1]), .s(s[1]), .c_out(c[2]));
	FA u2(.a(a[2]), .b(b[2]), .c_in(c[2]), .s(s[2]), .c_out(c[3]));
	FA u3(.a(a[3]), .b(b[3]), .c_in(c[3]), .s(s[3]), .c_out(c_out));
endmodule 

module FA (a, b, c_in, s, c_out);
	input a, b, c_in;
	output c_out, s;
	
	assign s	= a^b^c_in;
	assign c_out = (a & b)|(a & c_in)|(b & c_in);
endmodule



module part3(clock, reset, ParallelLoadn, RotateRight, ASRight, Data_IN, Q);
	input clock, reset, ParallelLoadn, RotateRight, ASRight;
	input [7:0] Data_IN;
	output [7:0] Q;
	wire [7:0] datato_dff;
	wire [7:0] rotatedata;
	wire arithmetic;
	
	mux2to1 M1(.x(Q[7]), .y(Q[1]), .s(RotateRight), .m(rotatedata[0]));
	mux2to1 M2(.x(Data_IN[0]), .y(rotatedata[0]), .s(ParallelLoadn), .m(datato_dff[0]));
	flipflop F0(.clock(clock), .Reset_b(reset), .q(Q[0]), .d(datato_dff[0]));
	
	mux2to1 M3(.x(Q[0]), .y(Q[2]), .s(RotateRight), .m(rotatedata[1]));
	mux2to1 M4(.x(Data_IN[1]), .y(rotatedata[1]), .s(ParallelLoadn), .m(datato_dff[1]));
	flipflop F1(.clock(clock), .Reset_b(reset), .q(Q[1]), .d(datato_dff[1]));

	mux2to1 M5(.x(Q[1]), .y(Q[3]), .s(RotateRight), .m(rotatedata[2]));
	mux2to1 M6(.x(Data_IN[2]), .y(rotatedata[2]), .s(ParallelLoadn), .m(datato_dff[2]));
	flipflop F2(.clock(clock), .Reset_b(reset), .q(Q[2]), .d(datato_dff[2]));

	mux2to1 M7(.x(Q[2]), .y(Q[4]), .s(RotateRight), .m(rotatedata[3]));
	mux2to1 M8(.x(Data_IN[3]), .y(rotatedata[3]), .s(ParallelLoadn), .m(datato_dff[3]));
	flipflop F3(.clock(clock), .Reset_b(reset), .q(Q[3]), .d(datato_dff[3]));

	mux2to1 M9(.x(Q[3]), .y(Q[5]), .s(RotateRight), .m(rotatedata[4]));
	mux2to1 M10(.x(Data_IN[4]), .y(rotatedata[4]), .s(ParallelLoadn), .m(datato_dff[4]));
	flipflop F4(.clock(clock), .Reset_b(reset), .q(Q[4]), .d(datato_dff[4]));

	mux2to1 M11(.x(Q[4]), .y(Q[6]), .s(RotateRight), .m(rotatedata[5]));
	mux2to1 M12(.x(Data_IN[5]), .y(rotatedata[5]), .s(ParallelLoadn), .m(datato_dff[5]));
	flipflop F5(.clock(clock), .Reset_b(reset), .q(Q[5]), .d(datato_dff[5]));

	mux2to1 M13(.x(Q[5]), .y(Q[7]), .s(RotateRight), .m(rotatedata[6]));
	mux2to1 M14(.x(Data_IN[6]), .y(rotatedata[6]), .s(ParallelLoadn), .m(datato_dff[6]));
	flipflop F6(.clock(clock), .Reset_b(reset), .q(Q[6]), .d(datato_dff[6]));

	mux2to1 M0(.x(Q[0]), .y(Q[7]), .s(ASRight), .m(arithmetic));
	mux2to1 M15(.x(Q[6]), .y(arithmetic), .s(RotateRight), .m(rotatedata[7]));
	mux2to1 M16(.x(Data_IN[7]), .y(rotatedata[7]), .s(ParallelLoadn), .m(datato_dff[7]));
	flipflop F7(.clock(clock), .Reset_b(reset), .q(Q[7]), .d(datato_dff[7]));

endmodule

module flipflop (clock, Reset_b, q, d);
	input d, clock, Reset_b;
	output reg q;
	
	always @(posedge clock)
	begin
		if (Reset_b == 1'b1)
			q <= 0;
		else
			q <= d;
	end
endmodule 

module mux2to1 (x, y, s, m);
	input x, y, s;
	output m;
	
	assign m = (s)? y: x;
	
endmodule 
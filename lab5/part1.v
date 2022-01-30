module part1(Clock, Enable, Clear_b, CounterValue);
	input Clock, Enable, Clear_b;
	output [7:0] CounterValue;
	
	wire [7:0] Ts;

	assign Ts[0] = Enable;
	assign Ts[1] = Ts[0] & CounterValue[0];
	assign Ts[2] = Ts[1] & CounterValue[1];
	assign Ts[3] = Ts[2] & CounterValue[2];
	assign Ts[4] = Ts[3] & CounterValue[3];
	assign Ts[5] = Ts[4] & CounterValue[4];
	assign Ts[6] = Ts[5] & CounterValue[5];
	assign Ts[7] = Ts[6] & CounterValue[6];
	
	TFlipFlop tff0(
		.Clock(Clock),
		.Enable(Ts[0]),
		.Clear_b(Clear_b),
		.q(CounterValue[0])
	);
	TFlipFlop tff1(
		.Clock(Clock),
		.Enable(Ts[1]),
		.Clear_b(Clear_b),
		.q(CounterValue[1])
	);
	TFlipFlop tff2(
		.Clock(Clock),
		.Enable(Ts[2]),
		.Clear_b(Clear_b),
		.q(CounterValue[2])
	);
	TFlipFlop tff3(
		.Clock(Clock),
		.Enable(Ts[3]),
		.Clear_b(Clear_b),
		.q(CounterValue[3])
	);
	TFlipFlop tff4(
		.Clock(Clock),
		.Enable(Ts[4]),
		.Clear_b(Clear_b),
		.q(CounterValue[4])
	);
	TFlipFlop tff5(
		.Clock(Clock),
		.Enable(Ts[5]),
		.Clear_b(Clear_b),
		.q(CounterValue[5])
	);
	TFlipFlop tff6(
		.Clock(Clock),
		.Enable(Ts[6]),
		.Clear_b(Clear_b),
		.q(CounterValue[6])
	);
	TFlipFlop tff7(
		.Clock(Clock),
		.Enable(Ts[7]),
		.Clear_b(Clear_b),
		.q(CounterValue[7])
	);

endmodule

module TFlipFlop(Clock, Enable, Clear_b, q);
	input Clock, Enable, Clear_b;
	output reg q = 1'b0;
	
	always @(posedge Clock, negedge Clear_b)
	begin
	if (Clear_b == 1'b0)
		q <= 1'b0;
	
	else if (Enable == 1'b1)
		q <= ~q;
		
	else
		q <= q;
	
	end
endmodule

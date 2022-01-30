module part3(ClockIn, Resetn, Start, Letter, DotDashOut);
	input ClockIn, Resetn, Start;
	input [2:0] Letter;		//000 is A
	output DotDashOut;		//output is one LEDR
	
	reg [11:0] Sequence;
	always@(Letter)		//always block runs whenever Letter changes
	begin
		case(Letter)
				3'b000: Sequence = 12'b101110000000;
				3'b001: Sequence = 12'b111010101000;
				3'b010: Sequence = 12'b111010111010;
				3'b011: Sequence = 12'b111010100000;
				3'b100: Sequence = 12'b100000000000;
				3'b101: Sequence = 12'b101011101000;
				3'b110: Sequence = 12'b111011101000;
				3'b111: Sequence = 12'b101010100000;
				default: Sequence = 12'b101110000000;
		endcase
	end
	
	//want ratedivider to send a pulse every 0.5 seconds
	// every time pulse is sent, register will read a bit 
	
	//wire c;
	wire Enable;

	rateDivide r0(
			.Clock(ClockIn),
			.Reset(Reset),
			.RateDivider(8'b11111001),
			.Start(Start),
			.c(Enable)
	);
	
	//assign Enable = (c == 8'b00000000)?1:0;
	
	displayLEDR l0(
			.Clock(ClockIn),
			.Reset(Reset),
			.Enable(Enable),
			.Start(Start),
			.Seq(Sequence),
			.ShiftOut(DotDashOut)
	);
				
	
endmodule


module rateDivide(Clock, Reset, RateDivider,Start, c);
	input Clock, Reset, Start;
	input [7:0] RateDivider;
	reg [7: 0]count;
	output c;
	always @(posedge Clock, Reset)
		begin
			if (Start == 1'b1 || Reset == 1'b0)
				count <= RateDivider;
			else
				if (count == 8'b00000000)
					count <= RateDivider;
				else
					count <= count - 1;
		
		end
	assign c = (count == 8'b00000000)?1:0;
endmodule 

module displayLEDR(Clock,Reset, Enable, Start, Seq, ShiftOut);
	input Clock, Reset, Enable, Start;
	input [11:0] Seq;
	output reg ShiftOut;
	
	
	reg [11:0] Sequence;
	reg temp;
		
	always@(posedge Clock, Reset)
		begin
			if (Start)
				Sequence <= Seq;
			else if (Reset == 1'b0)
			begin
				Sequence <= 12'b000000000000;
				ShiftOut <= 1'b0;
			end
			else if (Enable == 1'b1)
			begin	
				ShiftOut <= Sequence[11];
				//temp <= Sequence[11];
				//Sequence <= Sequence >> 1;
				//Sequence[0] <= temp;
				Sequence <= {Sequence[10:0],Sequence[11]};
			end
		end
endmodule 

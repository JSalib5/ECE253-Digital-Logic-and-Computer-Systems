module part1 (MuxSelect, Input, Out);

	input [6:0] Input;
	input [2:0] MuxSelect;
	output reg Out;

	always @(Input, MuxSelect)
		begin 
			case(MuxSelect[2:0])
				3'b000: Out = Input[0];
				3'b001: Out = Input[1];
				3'b010: Out = Input[2];
				3'b011: Out = Input[3];
				3'b100: Out = Input[4];
				3'b101: Out = Input[5];
				3'b110: Out = Input[6];
				default: Out = Input[0];
			endcase 
		end 
endmodule 

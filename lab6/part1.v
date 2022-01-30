// Resetn synchronous reset when 0
// w input to detector
// z is output from detector
// Clock clock signal
// CurState outputs current state

module part1(Clock, Resetn, w, z, CurState);
   input Clock;
   input Resetn;
   input w;
   output z;
   output [3:0] CurState;

    reg [3:0] y_Q, Y_D; // y_Q represents current state, Y_D represents next state
    
    localparam A = 4'b0000, B = 4'b0001, C = 4'b0010, D = 4'b0011, E = 4'b0100, F = 4'b0101, G = 4'b0110;
    
    //State table
    //The state table should only contain the logic for state transitions
    //Do not mix in any output logic. The output logic should be handled separately.
    //This will make it easier to read, modify and debug the code.
    always@(*)
    begin: state_table
        case (y_Q)
            A: begin
						if (!w) Y_D = A;
						else Y_D = B;
               end
            B: begin
						if (!w) Y_D = A;
						else Y_D = C;
               end
            C: begin
						if (!w) Y_D = E;
						else Y_D = D;
					end
            D: begin
						if (!w) Y_D = E;
						else Y_D = F;
					end
            E: begin
						if (!w) Y_D = A;
						else Y_D = G;
					end
            F: begin
						if (!w) Y_D = E;
						else Y_D = F;
					end
            G: begin
						if (!w) Y_D = A;
						else Y_D = C;
					end
            default: Y_D = A;
        endcase
    end // state_table
    
    // State Registers
    always @(posedge Clock)
    begin: state_FFs
        if(Resetn == 1'b0)
            y_Q <=  A; // Should set reset state to state A
        else
            y_Q <= Y_D;
    end // state_FFS

    // Output logic
    // Set z to 1 when in relevant states
    assign z = ((y_Q == F) | (y_Q == G));
    assign CurState = y_Q;
endmodule

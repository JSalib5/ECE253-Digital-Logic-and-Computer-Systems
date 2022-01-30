module part2(ClockIn, Reset, Speed, CounterValue);
    input ClockIn, Reset;
    input [1:0] Speed;
    output [3:0] CounterValue;
    
    DisplayCounter dc0(
        .ClockIn(ClockIn),
        .Reset(Reset),
        .Speed(Speed),
        .CounterValue(CounterValue)
    );
endmodule

module DisplayCounter(ClockIn, Reset, Speed, CounterValue);
    input ClockIn, Reset;
    input [1:0] Speed;
    output reg [3:0] CounterValue;
    
    wire Enable;
    
    RateDivider r0(
        .ClockIn(ClockIn),
        .Reset(Reset),
        .Speed(Speed),
        .out(Enable)
    );
    
    always @(posedge ClockIn)
    begin
        if (Reset == 1'b1)
            CounterValue <= 4'b0000;
        else if (Enable == 1'b1)
            CounterValue <= CounterValue + 1;
    end
    
endmodule

module RateDivider(ClockIn, Reset, Speed, out);
    input ClockIn, Reset;
    input [1:0] Speed;
    output out;
    
    reg [10:0] q = 11'b00000000000;
    wire [10:0] d;
    
    mux4to1 m0(
        .a(11'b00000000000),
        .b(11'b00111110011),
        .c(11'b01111100111),
        .d(11'b11111001111),
        .s(Speed),
        .m(d)
    );
    
    assign out = (q == 11'b00000000000) ? 1'b1 : 1'b0;
    
    always @(posedge ClockIn)
    begin
        if (Reset == 1'b1)
            q <= d;
        else if (q == 11'b00000000000)
            q <= d;
        else
            q <= q - 1;
    end

endmodule

module mux4to1(a, b, c, d, s, m);
    input [10:0] a, b, c, d;
    input [1:0] s;
    output reg [10:0] m;
    
    always @(*)
    begin
        case(s)
            2'b00: m = a;
            2'b01: m = b;
            2'b10: m = c;
            2'b11: m = d;
            default: m = 11'b00000000000;
        endcase
    end
    
endmodule
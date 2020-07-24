`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module ClockMux
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED  = 1000000,
    WL_Counter  = 20,
    Partition   = 2 // Defines how you will split a second
)
/*** IN/OUT ***/
(
    // IN
    input       clk,
    
    // OUT
    // What am I outputting? The output here is a square wave
    // So should the first half second be 0 and the latter 1?
    // Decision: First half = 1, latter = 0
    output reg  Out
);
    /*
        Frequency is Cycles per seconds
        Basys3Frequency = 1000000 cycles / 1 second
        So let n = 0, every time it equals 1000000 it has been one second
    */
    
    // Log2(1000000)=19.9315685693242
    // So I need at least 20 bits to represent 1000000
    reg [WL_Counter - 1 : 0] i; // Holds the counter
    
    initial 
    begin
        Out = 1; // Starting with the positive edge on the seconds signal
        i   = 0;
    end
    
    always @(posedge clk)
    begin
        // Counting across half the clock speed to get half the second
        // A whole period is a second
        if (i == CLOCKSPEED/Partition) 
        begin
            i   <= 0;
            Out <= ~Out; // negating to generate the signal
        end
        else i <= i + 1;
    end

endmodule

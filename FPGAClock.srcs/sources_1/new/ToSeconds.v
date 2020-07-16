`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module ToSeconds
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED  = 1000000,
    WL_Counter  = 20
)
/*** IN/OUT ***/
(
    // IN
    input       clk,
    
    // OUT
    // What am I outputting? The output here is a square wave
    // So should the first half second be 0 and the latter 1?
    // Decision: First half = 1, latter = 0
    output reg  Seconds
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
        Seconds = 1; // Starting with the positive edge on the seconds signal
    end
    
    always @(posedge clk)
    begin
        if (i == CLOCKSPEED/2) // Counting across half the clock speed to get half the second
        begin
            Seconds <= ~Seconds; // negating to generate the signal
        end
        else i <= i + 1;
    end

endmodule

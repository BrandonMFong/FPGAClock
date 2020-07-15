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
    output reg  Seconds
);
    /*
        Frequency is Cycles per seconds
        Basys3Frequency = 1000000 cycles / 1 second
        So let n = 0, every time it equals 1000000 it has been one second
    */
    
    // Log2(1000000)=19.9315685693242
    // So I need at least 20 bits to represent 1000000
    reg [WL_Counter - 1 : 0] i;
    
    always @(posedge clk)
    begin
        
    end

endmodule

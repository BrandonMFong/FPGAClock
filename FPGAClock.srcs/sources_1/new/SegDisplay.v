`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module SegDisplay
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED     = 100000000
)
/*** IN/OUT ***/
(
    // IN
    input                   QuarterSeconds,
    // OUT
    output reg [3 : 0]      SegmentDisplay, // Segment display
                            OutAnalogDisplay
);
    // STATES
    
    reg [3 : 0] var;
    
    initial 
    begin
        SegmentDisplay  = 4'b1110; // go right to left
        var             = 4'b0001;
    end              
    // TODO translate sec/min/hours to the SSD
    
    // Turns on segment display
    always @(posedge QuarterSeconds)
    begin
        // Instead of states, can I shift?
        if(var[3]) var      <= var ^ 4'b1001; // Left shift will 0 out the reg, xor by 9 to get 4'b0001
        else var            <= var << 1;
        SegmentDisplay      <= ~var;
        OutAnalogDisplay    <= ~var;
    end 
    
endmodule

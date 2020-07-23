`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module SevenSegment
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED     = 1000000
)
/*** IN/OUT ***/
(
    // IN
    input               QuarterSeconds,
                        clk,
    input [7 : 0]       Left_seconds,
                        Right_seconds,
                        Left_minutes,
                        Right_minutes,
                        Left_hours,
                        Right_hours,
    // OUT
    // Segment display
    output reg [3:0]    an
);
    // STATES
    localparam STATE_seg0 = 0, STATE_seg1 = 1, STATE_seg2 = 2, STATE_seg3 = 3;
    
    reg [1 : 0] SegDisplayState;
    reg [3 : 0] seg0, // Hour Left segment
                seg1, // Hour Right segment
                seg2, // Minute Left segment
                seg3; // Minute Right segment
    
    initial 
    begin
        SegDisplayState = 0; // First state is 0
        
    end              
    // TODO translate sec/min/hours to the SSD
    always @(posedge QuarterSeconds)
    begin
        // Instead of states, can I shift?
    end 
    
endmodule

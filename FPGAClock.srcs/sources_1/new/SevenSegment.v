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
    reg [3 : 0] seg;
    
    initial 
    begin
        SegDisplayState = 0; // First state is 0
//        an = 4'b1110; // go right to left
        seg = 4'b0001;
    end              
    // TODO translate sec/min/hours to the SSD
    
    // Turns on segment display
    always @(posedge QuarterSeconds)
    begin
        // Instead of states, can I shift?
        if(seg[3]) seg  <= seg ^ 4'b1001; // Left shift will 0 out the reg, xor by 9 to get 4'b0001
        else seg        <= seg << 1;
        an              <= ~seg;
    end 
    
endmodule

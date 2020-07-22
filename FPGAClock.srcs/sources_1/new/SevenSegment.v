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
    input [7 : 0]   Left_seconds,
                    Right_seconds,
                    Left_minutes,
                    Right_minutes,
                    Left_hours,
                    Right_hours
    // OUT
);
    
    reg [3 : 0] seg0, // Hour Left segment
                seg1, // Hour Right segment
                seg2, // Minute Left segment
                seg3; // Minute Right segment

    // TODO translate sec/min/hours to the SSD
    
endmodule

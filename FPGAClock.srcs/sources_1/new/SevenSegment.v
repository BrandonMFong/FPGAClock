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
    input                   clk,
    input [3 : 0]           SegmentDisplay,
    input [6 : 0]           LeftSeconds,
                            RightSeconds,
                            LeftMinutes,
                            RightMinutes,
                            LeftHours,
                            RightHours,
                            DefaultValue,
    // OUT
    output reg [6 : 0]      SegmentValue // Seven Segment value register
);
    // STATES
    localparam STATE_seg0 = 4'b0111, STATE_seg1 = 4'b1011, STATE_seg2 = 4'b1101, STATE_seg3 = 4'b1110;
    
    // Assign the value to the seg reg
    always @(SegmentDisplay)
    begin
        // Make a case where it checks to see if the seconds are being displayed too
        // It does not seem these assignments are working
        // Though they look okay, the output is not ideal 
        // I think it is an issue with the nonblocking
        // in the case, var is 0001, but the nonblocking assignment is saying it is 1000
        // The nonblocking assignment is turning seg0 on while the case below thinks it is turning seg3 on
        case(SegmentDisplay)
             // Right Minute
            STATE_seg0: SegmentValue    <= LeftHours;
            // Left Minute
            STATE_seg1: SegmentValue    <= RightHours;
            // Right Hour
            STATE_seg2: SegmentValue    <= LeftMinutes;
            // Left Hour
            STATE_seg3: SegmentValue    <= RightMinutes;
            // Default value
            default SegmentValue        <= DefaultValue;
        endcase 
    end 
    
endmodule

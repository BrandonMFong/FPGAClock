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
    input [6 : 0]       LeftSeconds,
                        RightSeconds,
                        LeftMinutes,
                        RightMinutes,
                        LeftHours,
                        RightHours,
                        DefaultValue,
    // OUT
    output reg [3 : 0]    SegmentDisplay, // Segment display
    output reg [6 : 0]    SegmentValue // Seven Segment value register
);
    // STATES
    localparam STATE_seg0 = 4'b1000, STATE_seg1 = 4'b0100, STATE_seg2 = 4'b0010, STATE_seg3 = 4'b0001;
    
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
        if(var[3]) var  <= var ^ 4'b1001; // Left shift will 0 out the reg, xor by 9 to get 4'b0001
        else var        <= var << 1;
        SegmentDisplay  <= ~var;
    end 
    
    // Assign the value to the seg reg
    always @(var)
    begin
        // Make a case where it checks to see if the seconds are being displayed too
        case(var)
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

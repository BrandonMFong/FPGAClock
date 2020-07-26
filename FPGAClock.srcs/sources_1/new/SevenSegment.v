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
                            MODE_ShowSeconds,
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
        // seg[n] has a fade display of seg[n-1] 

        // Show seconds
        if(MODE_ShowSeconds)
        begin 
            case(SegmentDisplay)
                // DefaultValue
                STATE_seg0: SegmentValue    <= DefaultValue;
                // DefaultValue
                STATE_seg1: SegmentValue    <= DefaultValue;
                // Right Seconds
                STATE_seg2: SegmentValue    <= LeftSeconds;
                // Left Seconds
                STATE_seg3: SegmentValue    <= RightSeconds;
                // Default value
                default SegmentValue        <= DefaultValue;
            endcase 
        end 
        else
        begin 
            case(SegmentDisplay)
                // Left Hour
                STATE_seg0: SegmentValue    <= LeftHours;
                // Right Hour
                STATE_seg1: SegmentValue    <= RightHours;
                // Left Minute
                STATE_seg2: SegmentValue    <= LeftMinutes;
                // Right Minute
                STATE_seg3: SegmentValue    <= RightMinutes;
                // Default value
                default SegmentValue        <= DefaultValue;
            endcase 
        end
    end 
    
endmodule

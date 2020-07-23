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
    output reg [3:0]    an,// Segment display
    output reg [6:0]    seg// Seven Segment value register
);
    // STATES
    localparam STATE_seg0 = 4'b1000, STATE_seg1 = 4'b0100, STATE_seg2 = 4'b0010, STATE_seg3 = 4'b0001;
    
    reg [1 : 0] SegDisplayState;
    reg [3 : 0] var;
    
    initial 
    begin
        SegDisplayState = 0; // First state is 0
//        an = 4'b1110; // go right to left
        var             = 4'b0001;
    end              
    // TODO translate sec/min/hours to the SSD
    
    // Turns on segment display
    always @(posedge QuarterSeconds)
    begin
        // Instead of states, can I shift?
        if(var[3]) var  <= var ^ 4'b1001; // Left shift will 0 out the reg, xor by 9 to get 4'b0001
        else var        <= var << 1;
        an              <= ~var;
    end 
    
    // Assign the value to the seg reg
    always @(var)
    begin
        case(var)
            STATE_seg0: // Right Minute
            begin
                
            end 
            STATE_seg1: // Left Minute
            begin
                
            end 
            STATE_seg2: // Right Hour
            begin
                
            end 
            STATE_seg3: // Left Hour
            begin
                
            end 
            // TODO what default be?
        endcase 
    end 
    
endmodule

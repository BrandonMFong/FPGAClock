`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module TopModule
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED     = 1000000
)
/*** IN/OUT ***/
(
    // IN
    input               clk,    // For the internal clock
                        btnC,   // Function: 
                        btnU,   // Function: 
                        btnL,   // Function: 
                        btnR,   // Function: 
                        btnD,   // Function: 
    // Switches
    // TODO figure out functions
    input [15:0]        sw,
    
    // OUT
    // Seven Segment LED 
    output reg [6:0]    seg,
    
    // Seven Segment
    output reg [3:0]    an,
    
    output reg          dp // I think this is the decimal points on the bottom of the seven segment display
);
    /* MODULES START */
    
    Clock
    #(
        .CLOCKSPEED(CLOCKSPEED)
    )
    mod0
    (
        .clk(clk)
    );
    
    /* MODULES END */
endmodule

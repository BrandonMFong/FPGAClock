`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module ControlCenter
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED  = 1000000
)
/*** IN/OUT ***/
(
    // IN
    input           clk,    // Probably won't need this
                    btnC,   // Function: 
                    btnU,   // Function: 
                    btnL,   // Function: 
                    btnR,   // Function: 
                    btnD,   // Function: 
    // Switches
    // TODO figure out functions
    input [15:0]    sw,
    
    // OUT
    // These outputs should output wires that define states
    // i.e. reset button
    
    // Data signals
    output          reset, // Resets clock back to 
    
    // State signals
    output          MODE_Setup
);
endmodule

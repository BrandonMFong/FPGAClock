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
    CLOCKSPEED  = 100000000
)
/*** IN/OUT ***/
(
    // IN
    input           clk,    // Probably won't need this
                    btnC,   // Function: 
                    btnU,   // Function: increase
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
                    // TODO find better names
                    increase, // Increases time
                    decrease, // Decreases time
                    MODE_Setup, // To set the time
                    MODE_ShowSeconds,
                    MODE_IsMilitaryTime,
                    MODE_Off
);

    // assign MODE_Setup           = sw[0] ? 1 : 0;
    assign reset                = (sw[15] && btnC);
    assign increase             = (MODE_Setup && btnU);
    assign decrease             = (MODE_Setup && btnD);
    assign MODE_ShowSeconds     = sw[0];
    assign MODE_Setup           = sw[1];
    assign MODE_IsMilitaryTime  = sw[14];
    assign MODE_Off             = sw[15];
endmodule

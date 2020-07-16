`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module Clock
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED  = 1000000
)
/*** IN/OUT ***/
(
    // IN
    input   clk, 
            reset,
            Seconds // Signal for clock
);
endmodule

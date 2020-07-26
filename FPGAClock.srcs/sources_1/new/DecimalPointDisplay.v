`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module DecimalPointDisplay
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED  = 1000000
)
/*** IN/OUT ***/
(
    // IN
    input   Seconds,
            IsInSetup,
    
    // OUT
    // What am I outputting? The output here is a square wave
    // So should the first half second be 0 and the latter 1?
    // Decision: First half = 1, latter = 0
    output  DecimalPoint
);

    assign DecimalPoint = IsInSetup ? 0 : Seconds;
endmodule

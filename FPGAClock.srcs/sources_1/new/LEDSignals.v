`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module LEDSignals
/*** IN/OUT ***/
(
    // IN
    // input   IsMilitaryTime,
    
    // OUT
    // These outputs should output wires that define states
    // i.e. reset button
    
    // Data signals
    output [15 : 0]  led
);

    // So initial state for switches and led is 0
    // assign led[15]  = IsMilitaryTime;
    assign led[15]  = 0;
endmodule

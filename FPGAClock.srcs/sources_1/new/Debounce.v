`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module Debounce
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED                  = 100000000,
    DebounceThreshold           = 100000,
    IncreaseFrequencyThreshold  = 30,
    DecreaseFactor              = 100
)
/*** IN/OUT ***/
(   
    // IN
    input       clk,
                In,
    
    // OUT
    output reg  Out
);
    reg [31 : 0]    i, j, DThresh;
    reg ThresholdReached;

    initial
    begin
        Out                 = 0;
        i                   = 0;
        j                   = 0;
        DThresh             = DebounceThreshold;
        ThresholdReached    = 0;
    end
    
    always @(posedge clk)
    begin
        if(In)
        begin
            if(i == DThresh) // If I held on to the button enough to trigger an increment
            begin
                // Will increase the speed of the increase if this is met
                if(j == IncreaseFrequencyThreshold) 
                begin
                    DThresh             <= DebounceThreshold / DecreaseFactor; // Decrease the threshold to make it faster
                    j                   <= 0;
                    ThresholdReached    <= 1;
                end
                else j <= !ThresholdReached ? j + 1 : j + 0; // Will not set this to anything else since we are already up to speed 
                Out <= ~Out;
                i   <= 0;
            end
            else i <= i + 1;
        end
        else 
        begin
            i                   <= 0;
            j                   <= 0;
            DThresh             <= DebounceThreshold;
            ThresholdReached    <= 0;
        end
    end

endmodule

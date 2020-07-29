`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module PulseWidthModulation
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED          = 100000000,
    SpeedUpThreshold    = 5,
    DivDefault          = 100000
)
/*** IN/OUT ***/
(   
    // IN
    input       clk,
                In,
    
    // OUT
    output reg  Out
);
    reg [31 : 0]    i,
                    ThresholdCounter,
                    Dividend;

    initial
    begin
        Out                 = 0;
//        In                  = 0;
        i                   = 0;
        ThresholdCounter    = 0;
        Dividend            = DivDefault;
    end
    
    always @(posedge clk)
    begin
//        if(In)
//        begin
//            if(ThresholdCounter == SpeedUpThreshold) Dividend <= Dividend / 10; // Log up
//            else ThresholdCounter <= ThresholdCounter + 1;
//            if(i == CLOCKSPEED/Dividend)
//            begin
//                Out <= ~Out;
//                i   <= 0;
//            end
//            else i <= i + 1;
//        end
//        else begin
//            i                   <= 0;
//            ThresholdCounter    <= 0;
//            Dividend            <= 1000;
//            Out                 <= 0;
//        end
        if(In)
        begin
            Out <= ~Out;
        end
    end

endmodule

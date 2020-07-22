`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////

// This is the back logic that increments the time for seconds
module Clock
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED      = 1000000,
    IsMilitaryTime  = 0
)
/*** IN/OUT ***/
(
    // IN
    input           clk, 
                    reset,
                    Seconds, // Signal for clock
                    MODE_Setup,
            
    // OUT
    // This time I want to output only one register
    // There are 4 segments, each 4 bits long
    // So the register should be 16 bits long
    output [7 : 0]  Left_seconds,
                    Right_seconds,
                    Left_minutes,
                    Right_minutes,
                    Left_hours,
                    Right_hours
);
    
    reg         IsPM;
    reg [3 : 0] second_segment_threshold,
                minute_segment_threshold,
                hourR_segment_threshold,
                hourL_segment_threshold;
    reg [7 : 0] secL,
                secR,
                minL,
                minR,
                hourL,
                hourR;
                
    // Initialize variables for the time
    initial begin
        IsPM                        = 0;
        second_segment_threshold    = 9;
        minute_segment_threshold    = 9;
        secL                        = 0;
        secR                        = 0;
        minL                        = 0;
        minR                        = 0;
        
        // Start time for Military time is 00:00
        // For non military is 12:00 AM
        if(IsMilitaryTime)
        begin
            hourL                   = 0;
            hourR                   = 0;
            hourL_segment_threshold = 2;
            hourR_segment_threshold = 4;
        end
        else 
        begin
            hourL                   = 1;
            hourR                   = 2;
            hourL_segment_threshold = 1;
            hourR_segment_threshold = 2;
        end
    end 
    
    // Where do I put the reset?  in a separate always block?
    always @(posedge Seconds)
    begin
        // If we are in setup mode, then we are not incrememnting the seconds
        // i.e. time is paused
        if(!MODE_Setup)
        begin 
            // Seconds
            if(secR == (second_segment_threshold))
            begin 
                secR <= 0;
                if(secL == (second_segment_threshold))
                begin
                    secL <= 0;
                    // Minutes
                    if(minR == (minute_segment_threshold))
                    begin
                        minR <= 0;
                        if(minL == (minute_segment_threshold))
                        begin
                            minL <= 0;
                            // Hours
                            if(hourR == (hourR_segment_threshold))
                            begin
                                if(IsMilitaryTime) hourR    <= 0;
                                else hourR                  <= 2;
                                if(hourL == (hourL_segment_threshold))
                                begin
                                    if(IsMilitaryTime) hourL    <= 0;
                                    else hourL                  <= 0;
                                end 
                                else hourL <= hourL + 1;
                            end 
                            else hourR <= hourR + 1;
                        end 
                        else minL <= minL + 1;
                    end 
                    else minR <= minR + 1;
                end 
                else secL <= secL + 1;
            end
            else secR <= secR + 1;
        end
    end
    
    // Output the registers
    assign Left_seconds     = secL;
    assign Right_seconds    = secR;
    assign Left_minutes     = minL;
    assign Right_minutes    = minR;
    assign Left_hours       = hourL;
    assign Right_hours      = hourR;
    
endmodule

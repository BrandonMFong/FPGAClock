`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////

// This is the back logic that increments the time for seconds
module ClockLogic
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED      = 100000000,
    IsMilitaryTime  = 0
)
/*** IN/OUT ***/
(
    // IN
    input           reset,
                    Pulse, // Whatever is being passed, i.e. seconds, clock, debounce
                    // MODE_Setup,
                    // DebouncePulse,
            
    // OUT
    // This time I want to output only one register
    // There are 4 segments, each 4 bits long
    // So the register should be 16 bits long
    output [7 : 0]  LeftSeconds,
                    RightSeconds,
                    LeftMinutes,
                    RightMinutes,
                    LeftHours,
                    RightHours
);
    
    reg         IsPM;
    reg [3 : 0] secondR_segment_threshold,
                secondL_segment_threshold,
                minuteR_segment_threshold,
                minuteL_segment_threshold,
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
        secondR_segment_threshold   = 9;
        secondL_segment_threshold   = 5;
        minuteR_segment_threshold   = 9;
        minuteL_segment_threshold   = 5;
        secL                        = 0;
        secR                        = 0;
        minL                        = 0;
        minR                        = 0;
        
        // Start time for Military time is 00:00
        // For non military is 12:00 AM
        // This is a problem because it does not go through 3 - 9 
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
    
    // The pulse increments the time
    // I think I can utilize this pulse with a pwm to increase the time asynchronous to the seconds pulse
    always @(posedge Pulse)
    begin
        // // If we are in setup mode, then we are not incrememnting the seconds
        // // i.e. time is paused
        // if(!MODE_Setup)
        // begin 
            // Seconds
            if(secR == (secondR_segment_threshold))
            begin 
                secR <= 0;
                if(secL == (secondL_segment_threshold))
                begin
                    secL <= 0;
                    // Minutes
                    if(minR == (minuteR_segment_threshold))
                    begin
                        minR <= 0;
                        if(minL == (minuteL_segment_threshold))
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
        // end
    end

    // Output the registers
    assign LeftSeconds     = secL;
    assign RightSeconds    = secR;
    assign LeftMinutes     = minL;
    assign RightMinutes    = minR;
    assign LeftHours       = hourL;
    assign RightHours      = hourR;
    
endmodule

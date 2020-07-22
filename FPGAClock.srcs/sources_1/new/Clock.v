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
    CLOCKSPEED  = 1000000
)
/*** IN/OUT ***/
(
    // IN
    input               clk, 
                        reset,
                        Seconds, // Signal for clock
            
    // OUT
    // This time I want to output only one register
    // There are 4 segments, each 4 bits long
    // So the register should be 16 bits long
    output reg [15 : 0] Segments
);
    
    reg [3 : 0] seg0, // Hour Left segment
                seg1, // Hour Right segment
                seg2, // Minute Left segment
                seg3, // Minute Right segment
                SecondsCounter;

    always @(posedge Seconds)
    begin
        if (SecondsCounter == 60)
        begin
            SecondsCounter <= 0; // Reset the counter
            
            // TODO increment the seconds
            // How do I want to do this?
        end
        else SecondsCounter = SecondsCounter + 1;
    end
endmodule

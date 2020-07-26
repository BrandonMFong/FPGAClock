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
    CLOCKSPEED      = 100000000
)
/*** IN/OUT ***/
(
    // IN
    input           clk, 
                    reset,
                    Seconds, // Signal for clock
                    MODE_Setup,
                    increase,
                    IsMilitaryTime,
            
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
    wire            Pulse;
    wire [7 : 0]    wire_secL,
                    wire_secR,
                    wire_minL,
                    wire_minR,
                    wire_hourL,
                    wire_hourR;
    reg [7 : 0]     reg_secL,
                    reg_secR,
                    reg_minL,
                    reg_minR,
                    reg_hourL,
                    reg_hourR;
                
    

    // I can probably use a pulse modulator instead of a Debounce signal
    assign Pulse = MODE_Setup ? increase : Seconds;

    ClockLogic #(.CLOCKSPEED(CLOCKSPEED))
    mod0_Seconds
    (
        .reset(reset),.Pulse(Pulse),.IsMilitaryTime(IsMilitaryTime),
        .LeftSeconds(wire_secL),.RightSeconds(wire_secR),
        .LeftMinutes(wire_minL),.RightMinutes(wire_minR),
        .LeftHours(wire_hourL),.RightHours(wire_hourR)
    );

    always  @(wire_secL,
            wire_secR,
            wire_minL,
            wire_minR,
            wire_hourL,
            wire_hourR)
    begin
        
        reg_secL    <= wire_secL;
        reg_secR    <= wire_secR;
        reg_minL    <= wire_minL;
        reg_minR    <= wire_minR;
        reg_hourL   <= wire_hourL;
        reg_hourR   <= wire_hourR;
    end



    // Output the registers
    // Put a mux here
    // I need to assign from registers
   assign LeftSeconds     = reg_secL;
   assign RightSeconds    = reg_secR;
   assign LeftMinutes     = reg_minL;
   assign RightMinutes    = reg_minR;
   assign LeftHours       = reg_hourL;
   assign RightHours      = reg_hourR;
    
endmodule

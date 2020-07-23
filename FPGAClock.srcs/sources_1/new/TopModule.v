`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////

// TODO translate sec/min/hours to the SSD

module TopModule
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED     = 1000000
)
/*** IN/OUT ***/
(
    // IN
    input               clk,    // For the internal clock
                        btnC,   // Function: 
                        btnU,   // Function: 
                        btnL,   // Function: 
                        btnR,   // Function: 
                        btnD,   // Function: 
    // Switches
    // TODO figure out functions
    input [15:0]        sw,
    
    // OUT
    // Seven Segment value register
    output reg [6:0]    seg,
    
    // Seven Segment
    output reg [3:0]    an,
    
    output reg          dp // I think this is the decimal points on the bottom of the seven segment display
);

    // WIRES
    // <NAME>_<Source>_<Destination, ... Destination+1>
    wire            Seconds_ClockMux_Clock,
                    reset_ControlCenter_Clock,
                    QuarterSeconds_ClockMux_SSDTranslation;
    wire [7 : 0]    LeftSeconds_Clock_SSDTranslation,
                    RightSeconds_Clock_SSDTranslation,
                    LeftMinutes_Clock_SSDTranslation,
                    RightMinutes_Clock_SSDTranslation,
                    LeftHours_Clock_SSDTranslation,
                    RightHours_Clock_SSDTranslation;
    
    /* FUNCTION START */
    // Function definition to calculate the ceiling of log base 2
    function integer clogb2;
        input [31:0] value;
        integer 	i;
        begin
            clogb2 = 0;
            for(i = 0; 2**i < value; i = i + 1) 
            clogb2 = i + 1;
        end
    endfunction
    /* FUNCTION END */
    
    /* MODULES START */
    
    // Clock
    Clock
    #(
        .CLOCKSPEED(CLOCKSPEED)
    )
    mod0
    (
        // IN
        .clk(clk),
        .reset(reset_ControlCenter_Clock),
        .Seconds(Seconds_ClockMux_Clock),
        .MODE_Setup(),
        
        // OUT 
        .LeftSeconds(LeftSeconds_Clock_SSDTranslation),
        .RightSeconds(RightSeconds_Clock_SSDTranslation),
        .LeftMinutes(LeftMinutes_Clock_SSDTranslation),
        .RightMinutes(RightMinutes_Clock_SSDTranslation),
        .LeftHours(LeftHours_Clock_SSDTranslation),
        .RightHours(RightHours_Clock_SSDTranslation)
    );
    
    // SevenSegment
    SevenSegment
    #(
        .CLOCKSPEED(CLOCKSPEED)
    )
    mod1
    (
        // IN
        .QuarterSeconds(QuarterSeconds_ClockMux_SevenSegment),
        .clk(clk),
//        .Left_seconds(Left_seconds_Clock_SevenSegment),
//        .Right_seconds(Right_seconds_Clock_SevenSegment),
//        .Left_minutes(Left_minutes_Clock_SevenSegment),
//        .Right_minutes(Right_minutes_Clock_SevenSegment),
//        .Left_hours(Left_hours_Clock_SevenSegment),
//        .Right_hours(Right_hours_Clock_SevenSegment),
        
        // OUT
        .an(an) 
    );
    
    // ToSeconds
    ClockMux
    #(
        .CLOCKSPEED(CLOCKSPEED),
        .WL_Counter(clogb2(CLOCKSPEED)), // This might throw an error because is it really returning a constant?
        .Partition(2) // One period is one second
    )
    mod2_ToSeconds
    (
        .clk(clk),
        .Out(Seconds_ClockMux_Clock)
    );
    
    // ToQuarterSeconds
    ClockMux
    #(
        .CLOCKSPEED(CLOCKSPEED),
        .WL_Counter(clogb2(CLOCKSPEED)), // This might throw an error because is it really returning a constant?
        .Partition(8) // One period is .25 of a second
    )
    mod2_ToQuarterSeconds
    (
        .clk(clk),
        .Out(QuarterSeconds_ClockMux_SevenSegment)
    );
    
    // ControlCenter
    ControlCenter
    #(
        .CLOCKSPEED(CLOCKSPEED)
    )
    mod3
    (
        .clk(clk),
        .btnC(btnC),   // Function: 
        .btnU(btnU),   // Function: 
        .btnL(btnL),   // Function: 
        .btnR(btnR),   // Function: 
        .btnD(btnD),   // Function: 
        .sw(sw),
        
        // OUT 
        .reset(reset_ControlCenter_Clock),
        .increase(),
        .decrease(),
        .MODE_Setup()
    );
    
    // RightSeconds
    SSDTranslation
    mod4_RightSeconds
    (
        // IN
        .Value(RightSeconds_Clock_SSDTranslation),
        
        // OUT 
        .Result(reset_ControlCenter_Clock)
    );
    
    // LeftSeconds
    SSDTranslation
    mod4_LeftSeconds
    (
        // IN
        .Value(LeftSeconds_Clock_SSDTranslation),
        
        // OUT 
        .Result(reset_ControlCenter_Clock)
    );
    
    // RightMinutes
    SSDTranslation
    mod4_RightMinutes
    (
        // IN
        .Value(RightMinutes_Clock_SSDTranslation),
        
        // OUT 
        .Result(reset_ControlCenter_Clock)
    );
    
    // LeftMinutes
    SSDTranslation
    mod4_LeftMinutes
    (
        // IN
        .Value(LeftMinutes_Clock_SSDTranslation),
        
        // OUT 
        .Result(reset_ControlCenter_Clock)
    );
    
    // RightHours
    SSDTranslation
    mod4_RightHours
    (
        // IN
        .Value(RightHours_Clock_SSDTranslation),
        
        // OUT 
        .Result(reset_ControlCenter_Clock)
    );
    
    // LeftHours
    SSDTranslation
    mod4_LeftHours
    (
        // IN
        .Value(LeftHours_Clock_SSDTranslation),
        
        // OUT 
        .Result(reset_ControlCenter_Clock)
    );
    /* MODULES END */
    
//    initial begin 
//    end
    
endmodule

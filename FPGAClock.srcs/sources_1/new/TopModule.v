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
    // Seven Segment LED 
    output reg [6:0]    seg,
    
    // Seven Segment
    output reg [3:0]    an,
    
    output reg          dp // I think this is the decimal points on the bottom of the seven segment display
);

    // WIRES
    // <NAME>_<Source>_<Destination>
    wire            Seconds_ToSeconds_Clock,
                    reset_ControlCenter_Clock;
    wire [7 : 0]    Left_seconds_Clock_SevenSegment,
                    Right_seconds_Clock_SevenSegment,
                    Left_minutes_Clock_SevenSegment,
                    Right_minutes_Clock_SevenSegment,
                    Left_hours_Clock_SevenSegment,
                    Right_hours_Clock_SevenSegment;
    
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
        .Seconds(Seconds_ToSeconds_Clock),
        .MODE_Setup(),
        
        // OUT 
        .Left_seconds(Left_seconds_Clock_SevenSegment),
        .Right_seconds(Right_seconds_Clock_SevenSegment),
        .Left_minutes(Left_minutes_Clock_SevenSegment),
        .Right_minutes(Right_minutes_Clock_SevenSegment),
        .Left_hours(Left_hours_Clock_SevenSegment),
        .Right_hours(Right_hours_Clock_SevenSegment)
    );
    
    // SevenSegment
    SevenSegment
    #(
        .CLOCKSPEED(CLOCKSPEED)
    )
    mod1
    (
        // IN
        .clk(clk),
        .Left_seconds(Left_seconds_Clock_SevenSegment),
        .Right_seconds(Right_seconds_Clock_SevenSegment),
        .Left_minutes(Left_minutes_Clock_SevenSegment),
        .Right_minutes(Right_minutes_Clock_SevenSegment),
        .Left_hours(Left_hours_Clock_SevenSegment),
        .Right_hours(Right_hours_Clock_SevenSegment)
        
        // OUT
    );
    
    // ToSeconds
    ToSeconds
    #(
        .CLOCKSPEED(CLOCKSPEED),
        .WL_Counter(clogb2(CLOCKSPEED)) // This might throw an error because is it really returning a constant?
    )
    mod2
    (
        .clk(clk),
        .Seconds(Seconds_ToSeconds_Clock)
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
    /* MODULES END */
    
//    initial begin 
//    end
    
endmodule

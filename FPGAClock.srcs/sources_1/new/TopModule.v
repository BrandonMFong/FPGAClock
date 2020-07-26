`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////

// TODO code pwm 

module TopModule
/*** PARAMETERS ***/
#(parameter
    // WL
    CLOCKSPEED      = 100000000,
    DefaultSSDValue = 0 // Connects to the Seven Segment module
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
    input [15:0]        sw,
    
    // OUT
    output [15:0]       led,
    // Seven Segment value register
    output [6:0]        seg,
    
    // Seven Segment
    output [3:0]        an,
    
    output              dp // I think this is the decimal points on the bottom of the seven segment display
);

    // WIRES
    // <NAME>_<Source>_<Destination[0],Destination[1],Destination[2], ... Destination[n],Destination[n+1]>
    wire            Seconds_ClockMux_Clock_DecimalPointDisplay,
                    reset_ControlCenter_Clock,
                    QuarterSeconds_ClockMux_SegDisplay,
                    MODE_ShowSeconds_ControlCenter_SevenSegment,
                    increase_ControlCenter_PulseWidthModulation,
                    increase_PulseWidthModulation_Clock,
                    MODE_Setup_ControlCenter_Clock,
                    MODE_IsMilitaryTime_ControlCenter_LEDSignals_Clock;
                    // DebouncePulse_ClockMux_Clock;
    wire [3 : 0]    SegmentDisplay_SegDisplay_SevenSegment;
    wire [6 : 0]    LeftSeconds_SSDTranslation_SevenSegment,
                    RightSeconds_SSDTranslation_SevenSegment,
                    LeftMinutes_SSDTranslation_SevenSegment,
                    RightMinutes_SSDTranslation_SevenSegment,
                    LeftHours_SSDTranslation_SevenSegment,
                    RightHours_SSDTranslation_SevenSegment,
                    DefaultSSDValue_SSDTranslation_SevenSegment;
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
            .Seconds(Seconds_ClockMux_Clock_DecimalPointDisplay),
            .MODE_Setup(MODE_Setup_ControlCenter_Clock),
            .increase(increase_PulseWidthModulation_Clock),
            .IsMilitaryTime(MODE_IsMilitaryTime_ControlCenter_LEDSignals_Clock),
            // .DebouncePulse(DebouncePulse_ClockMux_Clock),
            
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
            .clk(clk),
            .SegmentDisplay(SegmentDisplay_SegDisplay_SevenSegment),
            .LeftSeconds(LeftSeconds_SSDTranslation_SevenSegment),
            .RightSeconds(RightSeconds_SSDTranslation_SevenSegment),
            .LeftMinutes(LeftMinutes_SSDTranslation_SevenSegment),
            .RightMinutes(RightMinutes_SSDTranslation_SevenSegment),
            .LeftHours(LeftHours_SSDTranslation_SevenSegment),
            .RightHours(RightHours_SSDTranslation_SevenSegment),
            .DefaultValue(DefaultSSDValue_SSDTranslation_SevenSegment),
            .MODE_ShowSeconds(MODE_ShowSeconds_ControlCenter_SevenSegment),
            
            // OUT
            .SegmentValue(seg)
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
            // IN
            .clk(clk),

            // OUT 
            .Out(Seconds_ClockMux_Clock_DecimalPointDisplay)
        );
    
    // ToQuarterSeconds
    ClockMux
        #(
            .CLOCKSPEED(CLOCKSPEED),
            .WL_Counter(clogb2(CLOCKSPEED)), // This might throw an error because is it really returning a constant?
            .Partition(1000000) // One period is .25 of a second
        )
        mod2_ToQuarterSeconds
        (
            // IN
            .clk(clk),

            // OUT 
            .Out(QuarterSeconds_ClockMux_SegDisplay)
        );
    
    // // ToDebouncePulse
    // ClockMux
    //     #(
    //         .CLOCKSPEED(CLOCKSPEED),
    //         .WL_Counter(clogb2(CLOCKSPEED)), // This might throw an error because is it really returning a constant?
    //         .Partition(50000) 
    //     )
    //     mod2_ToDebouncePulse
    //     (
    //         // IN
    //         .clk(clk),

    //         // OUT 
    //         .Out(DebouncePulse_ClockMux_Clock)
    //     );
    
    // ControlCenter
    ControlCenter
        #(
            .CLOCKSPEED(CLOCKSPEED)
        )
        mod3
        (
            // IN
            .clk(clk),
            .btnC(btnC),   // Function: 
            .btnU(btnU),   // Function: 
            .btnL(btnL),   // Function: 
            .btnR(btnR),   // Function: 
            .btnD(btnD),   // Function: 
            .sw(sw),
            
            // OUT 
            .reset(reset_ControlCenter_Clock),
            .increase(increase_ControlCenter_PulseWidthModulation),
            .decrease(),
            .MODE_Setup(MODE_Setup_ControlCenter_Clock),
            .MODE_ShowSeconds(MODE_ShowSeconds_ControlCenter_SevenSegment),
            .MODE_IsMilitaryTime(MODE_IsMilitaryTime_ControlCenter_LEDSignals_Clock)
        );
    
    // RightSeconds
    SSDTranslation
        mod4_RightSeconds
        (
            // IN
            .Value(RightSeconds_Clock_SSDTranslation),
            
            // OUT 
            .Result(RightSeconds_SSDTranslation_SevenSegment)
        );
    
    // LeftSeconds
    SSDTranslation
        mod4_LeftSeconds
        (
            // IN
            .Value(LeftSeconds_Clock_SSDTranslation),
            
            // OUT 
            .Result(LeftSeconds_SSDTranslation_SevenSegment)
        );
    
    // RightMinutes
    SSDTranslation
        mod4_RightMinutes
        (
            // IN
            .Value(RightMinutes_Clock_SSDTranslation),
            
            // OUT 
            .Result(RightMinutes_SSDTranslation_SevenSegment)
        );
    
    // LeftMinutes
    SSDTranslation
        mod4_LeftMinutes
        (
            // IN
            .Value(LeftMinutes_Clock_SSDTranslation),
            
            // OUT 
            .Result(LeftMinutes_SSDTranslation_SevenSegment)
        );
    
    // RightHours
    SSDTranslation
        mod4_RightHours
        (
            // IN
            .Value(RightHours_Clock_SSDTranslation),
            
            // OUT 
            .Result(RightHours_SSDTranslation_SevenSegment)
        );
    
    // LeftHours
    SSDTranslation
        mod4_LeftHours
        (
            // IN
            .Value(LeftHours_Clock_SSDTranslation),
            
            // OUT 
            .Result(LeftHours_SSDTranslation_SevenSegment)
        );
    
    // DefaultSSDValue
    SSDTranslation
        mod4_DefaultSSDValue
        (
            // IN
            .Value(DefaultSSDValue),
            
            // OUT 
            .Result(DefaultSSDValue_SSDTranslation_SevenSegment)
        );
    
    // SegDisplay
    SegDisplay
        #(
            .CLOCKSPEED(CLOCKSPEED)
        )
        mod5
        (
            // IN
            .QuarterSeconds(QuarterSeconds_ClockMux_SegDisplay),
            
            // OUT 
            .SegmentDisplay(SegmentDisplay_SegDisplay_SevenSegment),
            .OutAnalogDisplay(an)
        );
    
    // DecimalPointDisplay
    DecimalPointDisplay
        #(
            .CLOCKSPEED(CLOCKSPEED)
        )
        mod6
        (
            // IN
            .Seconds(Seconds_ClockMux_Clock_DecimalPointDisplay),
            
            // OUT 
            .DecimalPoint(dp)
        );
    
    
    // DecimalPointDisplay
    PulseWidthModulation
        #(
            .CLOCKSPEED(CLOCKSPEED),
            .SpeedUpThreshold(5)
        )
        mod7
        (
            // IN
            .clk(clk),
            .In(increase_ControlCenter_PulseWidthModulation),
            
            // OUT 
            .Out(increase_PulseWidthModulation_Clock)
        );
    
    
    // LEDSignals
    LEDSignals
        mod8
        (
            // IN
            .IsMilitaryTime(MODE_IsMilitaryTime_ControlCenter_LEDSignals_Clock),
            
            // OUT 
            .led(led)
        );
    
    /* MODULES END */
    
//    initial begin 
//    end
    
endmodule

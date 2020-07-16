`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


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
    wire Seconds;
    
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
    
    Clock
    #(
        .CLOCKSPEED(CLOCKSPEED)
    )
    mod0
    (
        .clk(clk),
        .Seconds(Seconds)
    );
    
    SevenSegment
    #(
        .CLOCKSPEED(CLOCKSPEED)
    )
    mod1
    (
        .clk(clk)
    );
    
    ToSeconds
    #(
        .CLOCKSPEED(CLOCKSPEED),
        .WL_Counter(clogb2(CLOCKSPEED)) // This might throw an error because is it really returning a constant?
    )
    mod2
    (
        .clk(clk),
        .Seconds(Seconds)
    );
    
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
        .sw(sw)
    );
    /* MODULES END */
    
//    initial begin 
//    end
    
endmodule

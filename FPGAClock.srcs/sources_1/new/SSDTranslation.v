`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Brandon Fong
// 
// Create Date: 07/14/2020 05:04:05 PM
// 
//////////////////////////////////////////////////////////////////////////////////


module SSDTranslation
/*** IN/OUT ***/
(
    // IN
    input [7 : 0]   Value,
    // OUT
    output [6 : 0]  Result
);

    reg [6 : 0] SegValue;
    always @(Value)
    begin
       case(Value)
            0: SegValue         <= 7'b1000000;
            1: SegValue         <= 7'b1111001;
            2: SegValue         <= 7'b0100100;
            3: SegValue         <= 7'b0110000;
            4: SegValue         <= 7'b0011001;
            5: SegValue         <= 7'b0010010;
            6: SegValue         <= 7'b0000010;
            7: SegValue         <= 7'b1111000;
            8: SegValue         <= 7'b0000000;
            9: SegValue         <= 7'b0011000;
            default  SegValue   <= 7'b1000000;
        endcase
    end 
    
    assign Result = SegValue;
   
endmodule

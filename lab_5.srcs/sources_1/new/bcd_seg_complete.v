`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 04:25:46 PM
// Design Name: 
// Module Name: bcd_seg_complete
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bcd_seg_complete(CLK, BCD0, BCD1, BCD2, BCD3, AN, SEGN);
input CLK;
input [3:0] BCD0;
input [3:0] BCD1;
input [3:0] BCD2;
input [3:0] BCD3;
output [3:0] AN;
output [6:0] SEGN;

reg [3:0] BCD;

dig_cont (CLK, AN);
bcd_to_sevseg bcd3 (BCD, SEGN);

always @(posedge CLK)
begin
    if (AN == 4'b1110)
        BCD = BCD0;
    else if (AN == 4'b1101)
        BCD = BCD1;
    else if (AN == 4'b1011)
        BCD = BCD2;
    else if (AN == 4'b0111)
        BCD = BCD3;
    else;
end
endmodule

//testbench (uncomment below for simulation)

module complete_tb;
reg CLK;
reg [3:0] BCD0;
reg [3:0] BCD1;
reg [3:0] BCD2;
reg [3:0] BCD3;
wire [3:0] AN;
wire [6:0] SEGN;

always
begin
    CLK = 1'b0;
    #5;
    CLK = 1'b1;
    #5;
end

bcd_seg_complete dut (CLK, BCD0, BCD1, BCD2, BCD3, AN, SEGN);

initial begin
    BCD0 = 4'b0000;
    BCD1 = 4'b0000;
    BCD2 = 4'b0000;
    BCD3 = 4'b0000;
    #250
    BCD0 = 4'b0001;
    BCD1 = 4'b0010;
    BCD2 = 4'b0011;
    BCD3 = 4'b0100;
    #250
    BCD0 = 4'b0101;
    BCD1 = 4'b0110;
    BCD2 = 4'b0111;
    BCD3 = 4'b1000;
    #250
    BCD0 = 4'b1001;
    BCD1 = 4'b1010;
    BCD2 = 4'b1101;
    BCD3 = 4'b1111;
end
endmodule


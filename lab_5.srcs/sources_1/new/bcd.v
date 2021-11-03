`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 12:03:54 PM
// Design Name: 
// Module Name: bcd
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


module bcd_to_sevseg(BCD, segN);
input [3:0] BCD;
output [6:0] segN;

reg [6:0] segN;

always @(BCD)
begin
    if (BCD == 4'b0000)
        segN <= 7'b1000000;
    else if (BCD == 4'b0001)
        segN <= 7'b1111001;
    else if (BCD == 4'b0010)
        segN <= 7'b0100100;
    else if (BCD == 4'b0011)
        segN <= 7'b0110000;
    else if (BCD == 4'b0100)
        segN <= 7'b0011001;
    else if (BCD == 4'b0101)
        segN <= 7'b0010010;
    else if (BCD == 4'b0110)
        segN <= 7'b0000010;
    else if (BCD == 4'b0111)
        segN <= 7'b1111000;
    else if (BCD == 4'b1000)
        segN <= 7'b0000000;
    else if (BCD == 4'b1001)
        segN <= 7'b0010000;
    else
        segN <= 7'b1111111;
    end

endmodule

//testbench (uncomment below for simulation)

module bcd_tb;
wire [6:0] segN;
reg [3:0] BCD;

bcd_to_sevseg dut(BCD, segN);

initial begin
    BCD = 4'b0000;
    #10;
    BCD = 4'b0001;
    #10;
    BCD = 4'b0010;
    #10;
    BCD = 4'b0011;
    #10;
    BCD = 4'b0100;
    #10;
    BCD = 4'b0101;
    #10;
    BCD = 4'b0110;
    #10;
    BCD = 4'b0111;
    #10;
    BCD = 4'b1000;
    #10;
    BCD = 4'b1001;
    #10;
    BCD = 4'b1110;
    #10;
    BCD = 4'b1010;
    #10;
end
endmodule


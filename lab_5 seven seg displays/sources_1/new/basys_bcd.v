`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Dunwoody College of Technology
// Engineer: Jacob Kearin
// 
// Written in Vivado 2019.1
//
// Create Date: 10/06/2021 12:41:37 PM
// Design Name: 
// Module Name: basys_bcd
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


module basys_bcd(clk, sw, seg, an);
input clk;
input [15:0] sw;
output [6:0] seg;
output [3:0] an;

wire [3:0] BCD0;
wire [3:0] BCD1;
wire [3:0] BCD2;
wire [3:0] BCD3;

assign BCD0[0] = sw[0];
assign BCD0[1] = sw[1];
assign BCD0[2] = sw[2];
assign BCD0[3] = sw[3];
assign BCD1[0] = sw[4];
assign BCD1[1] = sw[5];
assign BCD1[2] = sw[6];
assign BCD1[3] = sw[7];
assign BCD2[0] = sw[8];
assign BCD2[1] = sw[9];
assign BCD2[2] = sw[10];
assign BCD2[3] = sw[11];
assign BCD3[0] = sw[12];
assign BCD3[1] = sw[13];
assign BCD3[2] = sw[14];
assign BCD3[3] = sw[15];

bcd_seg_complete(clk, BCD0, BCD1, BCD2, BCD3, an, seg);

endmodule

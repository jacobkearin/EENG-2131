`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2021 03:29:26 PM
// Design Name: 
// Module Name: HW3
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


module HW3(clk, S0, S1, SP, AR, D, BUF_OUT, OUT, FB);
input clk, S0, S1, SP, AR, D, BUF_OUT;
output OUT, FB;
reg Q = 0;

always @(posedge AR) Q <= 0;

always @(posedge clk) begin
    if (SP && !AR) Q <= 1;
    else if (!AR) Q <= D;
end

assign OUT = (S1) ? (S0 ? !D : D) : (S0 ? !Q : Q);
assign FB = (S1) ? BUF_OUT : !Q;

endmodule



module hw_3_1_tb;
reg clk = 0;
reg S0 = 0;
reg S1 = 0;
reg SP = 0;
reg AR = 0;
reg D = 0;
reg BUF_OUT = 0;
wire OUT, FB;

always begin
clk = !clk;
#5;
end

HW3 dut(clk, S0, S1, SP, AR, D, BUF_OUT, OUT, FB);

initial begin
#10;
D = 1; S1 = 1;
#5;
S0 = 1;
#15;
S0 = 0; S1 = 0;
#5;
D = 0;
#12;
SP = 1;
#7;
AR = 1;
#6;
S0 = 1;

end
endmodule

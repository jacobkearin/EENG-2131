`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/28/2021 11:42:48 AM
// Design Name: 
// Module Name: lab_4_part_4
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


module DLatch (CLK, D, CLR, Q);
    input CLK, D, CLR;
    output Q;
    reg Q;
    
    always @(CLR, CLK, D)
    begin
        if (~CLR)
            Q <= 0;
        else if (~CLK)
            Q <= D;
    end
endmodule 

module DLatch_tb;
wire Q;
reg D, CLK, CLR;

DLatch dut(CLK, D, CLR, Q);

always
begin
#5 CLK <= ~CLK;
end

initial begin
CLK = 0;
D = 0;
CLR = 1;
D = 1'b0; CLR = 1'b1;
#10;
D = 1'b1; CLR = 1'b1;
#12;
D = 1'b1; CLR = 1'b1;
#6;
D = 1'b0; CLR = 1'b1;
#4;
D = 1'b1; CLR = 1'b1;
#4;
D = 1'b1; CLR = 1'b1;
#10;
D = 1'b0; CLR = 1'b1;
#10;
D = 1'b1; CLR = 1'b0;
#10;
D = 1'b0; CLR = 1'b0;
#10;


end
endmodule


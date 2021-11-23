`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2021 01:26:57 PM
// Design Name: 
// Module Name: Lab_4_part_2
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


module DFFas (D, CLR, CLK, Q);
    input D, CLR, CLK;
    output Q;
    reg Q;

    always @(posedge CLK) 
    begin
        if (CLR)
            Q <= D;
    end
    
    always @(CLR or ~CLR) Q <= 0;
    
endmodule

module DFFas_tb;
wire Q;
reg D, CLR, CLK;

DFFas dut(D, CLR, CLK, Q);

always
begin
#5 CLK <= ~CLK;
end

initial begin
CLK = 0;
D = 1'b0; CLR = 1'b1;
#10;
D = 1'b1; CLR = 1'b1;
#10;
D = 1'b1; CLR = 1'b0;
#10;
D = 1'b0; CLR = 1'b0;
#10;
D = 1'b1; CLR = 1'b0;
#10;
D = 1'b1; CLR = 1'b1;
#10;
D = 1'b0; CLR = 1'b1;
#10;
D = 1'b1; CLR = 1'b1;
#10;
D = 1'b0; CLR = 1'b1;
#10;

end
endmodule

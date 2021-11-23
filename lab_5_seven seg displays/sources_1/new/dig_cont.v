`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/29/2021 12:56:04 PM
// Design Name: 
// Module Name: dig_cont
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


module dig_cont(clk, an);
input clk;
output [3:0] an;
reg [3:0] an;
reg [31:0] counter0 = 0;
reg [31:0] counter1 = 0;

parameter refresh_ms = 16;
parameter num_digits = 4;
parameter rate = refresh_ms * 100000; //add *100000

always @(posedge (clk))
begin
    counter0 = counter0 + 1;
    if (counter0 >= (rate / num_digits))
    begin    
        counter0 = 0;
        counter1 = counter1 + 1;
    end    
    if (counter1 >= (num_digits))
        counter1 = 0;
end

always @(posedge(clk))
begin
    if (counter1 == 0)
            an = 4'b0111;
    else if (counter1 == 1)
            an = 4'b1011;
    else if (counter1 == 2)
            an = 4'b1101;
    else if (counter1 == 3)
            an = 4'b1110;
    else 
        an <= 4'b1111;
end
endmodule


//testbench (uncomment below for simulation)

module dig_tb;
wire [3:0] an;
reg clk;

always
begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
end

dig_cont dut(clk, an);
initial begin
end

endmodule


`timescale 1ns / 1ps

module comparitor_4bit(A, B, GTin, EQin, LTin, GTout, EQout, LTout);
input [3:0] A, B;
input GTin, EQin, LTin;
output reg GTout, EQout, LTout;

always @(A, B, GTin, EQin, LTin) begin
    if (A > B) begin
        GTout <= 1;
        EQout <= 0;
        LTout <= 0;
    end else if (A < B) begin
        GTout <= 0;
        EQout <= 0;
        LTout <= 1;
    end else if (A == B) begin
        if (GTin || LTin) begin
            GTout <= GTin;
            EQout <= 0;
            LTout <= LTin;
        end else begin
            GTout <= 0;
            EQout <= 1;
            LTout <= 0;
        end
    end
end
endmodule

module comparitor_tb;
reg [3:0] A, B;
reg GTin, EQin, LTin;
wire GTout, EQout, LTout;

comparitor_4bit dut(A, B, GTin, EQin, LTin, GTout, EQout, LTout);

initial begin
A = 13;
B = 10;
GTin = 0;
EQin = 0;
LTin = 0;
#10
A = 8;
#10
A = 10;
#10
GTin = 1;
#10
GTin = 0;
EQin = 1;
#10
EQin = 0;
LTin = 1;

end

endmodule

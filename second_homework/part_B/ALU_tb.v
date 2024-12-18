/* ALU module_th*/
`timescale 1ns/1ps//調整單位時間為 1ns 
module ALU_tb;
reg [15:0] a,b;//要進行邏輯運算的輸入a,b
reg [2:0] op;//用以選擇的op
wire [15:0] y;//輸出的結果
wire cout;//輸出的cout

/*實例化ALU*/
ALU alu_module(y,cout,a,b,op);

/*波形模擬*/
initial begin
    /*算術功能測試*/
    a = 16'h8F54;
    b = 16'h79F8;
    op = 3'b000;
    #10 op = 3'b001;
    #10 op = 3'b010;
    #10 op = 3'b011;
    #10;
    /*邏輯功能測試*/
    a = 16'b1001_0011_1101_0010;
    b = 16'b1110_1100_1001_0111;
    op = 3'b100;
    #10 op = 3'b101;
    #10 op = 3'b110;
    #10 op = 3'b111;
    #10 $finish;
end
endmodule
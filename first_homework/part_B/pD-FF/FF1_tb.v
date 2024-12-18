//FF1_Testbench
`timescale 1ns/1ps
module FF1_tb;
reg clk;
reg rst;
reg d;
wire q_sync_ver;

FF1_Sync_Ver ff1_sync_ver(q_sync_ver,d,clk,rst);//引入測試module

// clk part
initial begin//依波形圖建立clk的初值及初始delay，以及clk在delay後的震盪週期
    clk = 0;
    #3;
    forever begin
        clk = ~clk;
        #5;
    end
end

//d and rst part
initial begin//依照給定的d及rst的波形圖撰寫之測試部分
    d = 0;
    rst = 0;
    #4 d = ~d;
    #1 d = ~d;
    #5 d = ~d;
    #5 d = ~d;
    #6 rst = ~rst;
    #6 d = ~d;
    #3 $finish;
end
endmodule
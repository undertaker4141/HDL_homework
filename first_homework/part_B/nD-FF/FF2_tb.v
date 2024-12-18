//FF2_Testbench
`timescale 1ns/1ps
module FF2_tb;
reg clk;
reg rst;
reg d;
wire q_async_ver;

FF2_Async_Ver ff2_async_ver(q_async_ver,d,clk,rst);//引入測試module

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
    d = 1;
    rst = 1;
    #5 d = ~d;
    #6 d = ~d;
    #10 rst = ~rst;
    #2 d = ~d;
    #7 $finish;
end
endmodule
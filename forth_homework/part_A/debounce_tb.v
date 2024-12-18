`timescale 1ns/1ps//調整單位時間為 1ns 
module debounce_tb;
reg clk;
reg in;
wire out;

debounce test(clk,in,out);

// clk part
initial begin
    clk = 0;
    #5;
    forever begin
        clk = ~clk;
        #5;
    end
end

// in part
initial begin
    in = 0;
    #8 in = 1;
    #3 in = 0;
    #3 in = 1;
    #3 in = 0;
    #4 in = 1;
    #3 in = 0;
    #3 in = 1;
    #46 in = 0;
    #3 in = 1;
    #3 in = 0;
    #4 in = 1;
    #3 in = 0;
    #2 in = 1;
    #3 in = 0;
end

initial begin
    #145 $finish;
end

endmodule
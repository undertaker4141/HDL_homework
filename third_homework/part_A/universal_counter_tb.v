`timescale 1ns/1ps//調整單位時間為 1ns 
module universal_counter_tb;
reg clear; 
reg mode;
reg incr;
reg pause; 
reg clk; 
wire [3:0] count;

universal_counter test(clear, mode, incr, pause, clk, count);

// clk part
initial begin
    clk = 0;
    #5;
    forever begin
        clk = ~clk;
        #5;
    end
end

// clear part
initial begin
    clear = 1;
    #20 clear = 0;
    #150 clear = 1;
    #10 clear = 0;
end

// pause part
initial begin
    pause = 0;
    #80 pause = 1;
    #30 pause = 0;
    #290 pause = 1;
end

// mode part
initial begin
    mode = 0;
    #180 mode = 1;
end

// incr part
initial begin
    incr = 1;
    #90 incr = 0;
    #90 incr = 1;
    #60 incr = 0;
    #20 incr = 1;
end

// incr part
initial begin
    #400 $finish;
end

endmodule
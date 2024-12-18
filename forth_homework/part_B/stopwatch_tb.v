`timescale 1s/1ps//調整單位時間為 1s 
module stopwatch_tb;
reg clk = 0;
reg reset;
reg start;
reg stop;
wire [1:0] minute;
wire [5:0] second;

stopwatch test(clk,reset,start,stop,minute,second);

// clk part
always #0.5 clk = ~clk;

// in part
initial begin
    reset = 1;
    start = 0;
    stop = 0;
    #3 reset = 0;
    #2 start = 1;
    #6 start = 0;
    #120 stop = 1;
    #4 stop = 0;
    #4 start = 1;
    #18 start = 0;
    #130 reset = 1;
end

initial begin
    #350 $finish;
end

endmodule
`timescale 1s/1ps//調整單位時間為 1s 
module stack_tb;
    reg clk;
    reg [7:0] data_in; /* input data for push operations, sampled at posedge clk */ 
    reg [1:0] cmd;     /* 00: no operation, 01: clear, 10: push, 00: pop, sampled at the positive 
                            edges of the clock */ 
  
    wire [7:0] data_out;  /* retrieved data for pop operations, changes at posedge clk */ 
    wire full;  /* flag set when the stack is full, updated at negedge clk */ 
    wire empty; /* flag set when the stack is empty, updated at negedge clk */ 
    wire error; /* flag set when push is asserted if stack is full or when pop is asserted if stack is  
                   empty, updated at negedge clk */ 

stack test(clk, data_in, cmd, data_out, full, empty, error);

// clk part
always #5 clk = ~clk;

// Testbench 
initial begin
    clk = 0;
    cmd = 2'b1;
    data_in = 8'hxx;
    #10
    cmd = 2'b11;
    data_in = 8'hxx;
    #10
    cmd = 2'b11;
    data_in = 8'hxx;
    #10
    cmd = 2'b10;
    data_in = 8'h01;
    #10
    cmd = 2'b10;
    data_in = 8'h02;
    #10
    cmd = 2'b0;
    data_in = 8'hxx;
    #10
    cmd = 2'b11;
    data_in = 8'hxx;
    #10
    cmd = 2'b10;
    data_in = 8'h03;
    #10
    cmd = 2'b10;
    data_in = 8'h04;
    #10
    cmd = 2'b10;
    data_in = 8'h05;
    #10
    cmd = 2'b10;
    data_in = 8'h06;
    #10
    cmd = 2'b10;
    data_in = 8'h07;
    #10
    cmd = 2'b10;
    data_in = 8'h08;
    #10
    cmd = 2'b10;
    data_in = 8'h09;
    #10
    cmd = 2'b10;
    data_in = 8'h0A;
    #10
    cmd = 2'b10;
    data_in = 8'h0B;
    #10
    cmd = 2'b10;
    data_in = 8'h0C;
    #10
    cmd = 2'b11;
    data_in = 8'hxx;
    #10
    cmd = 2'b11;
    data_in = 8'hxx;
    #10
    cmd = 2'b11;
    data_in = 8'hxx;
    #10
    cmd = 2'b0;
    data_in = 8'hxx;
    #10
    cmd = 2'b1;
    data_in = 8'hxx;
    #10
    cmd = 2'b10;
    data_in = 8'h10;
    #10
    cmd = 2'b11;
    data_in = 8'hxx;
    #10
    cmd = 2'b11;
    data_in = 8'hxx;
    #10
    cmd = 2'b0;
    data_in = 8'hxx;
    #10
    cmd = 2'b11;
    data_in = 8'hxx;
    #10
    cmd = 2'b0;
    data_in = 8'hxx;
    #10
    $finish;
end
endmodule
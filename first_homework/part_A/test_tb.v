`timescale 1ns/1ps
module test_tb;
reg clk;
reg [3:0]a,b;
wire [4:0] data_out; 
test test(.clk(clk), .a(a), .b(b), .data_out);

always #5 clk = ~clk;

initial begin
clk = 1'd0;
a = 4'b0100;
b = 4'b0001;
#50
a = 4'b0110;
b = 4'b0011;
#50
a = 4'b1100;
b = 4'b0001;
#50 
a = 4'b0100;
b = 4'b1011;

#30
$finish;
end
endmodule

 
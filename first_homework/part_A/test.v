module test(clk,a,b,data_out);
input clk;
input [3:0] a,b;
output reg [4:0] data_out;


always @(*) begin
	data_out = a + b;
end
endmodule
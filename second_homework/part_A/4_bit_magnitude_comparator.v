/* 4‐bit magnitude comparator module*/
module comparator_4b(data_a, data_b, gt, eq, lt);   

input [3:0] data_a; //要進行比較的輸入a,b
input [3:0] data_b;

output gt; /* gt = 1 if data_a > data_b */
output eq; /* eq = 1 if data_a == data_b */
output lt; /* lt = 1 if data_a < data_b */

assign gt = (data_a > data_b);
assign eq = (data_a == data_b);
assign lt = (data_a < data_b);
endmodule
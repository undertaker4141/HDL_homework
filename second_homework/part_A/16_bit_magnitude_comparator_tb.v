/* 16‐bit magnitude comparator module_th*/
`timescale 1ns/1ps//調整單位時間為 1ns 
module comparator_16b_th;

reg [15:0] data_a, data_b;//要進行比較的輸入a,b

wire a_gt_b; /* a_gt_b = 1 if data_a > data_b */
wire a_eq_b; /* a_eq_b = 1 if data_a == data_b */
wire a_lt_b; /* a_lt_b = 1 if data_a < data_b */

/*實例化comparator_16b,並使用"name mapping"*/
comparator_16b test(.data_a(data_a[15:0]),.data_b(data_b[15:0]),.a_gt_b(a_gt_b),.a_eq_b(a_eq_b),.a_lt_b(a_lt_b));

/*波形模擬*/
initial begin
    data_a = 16'h04F8;
    data_b = 16'h04F7;

    #10 data_b=16'h04FA;

    #10 data_a=16'h04FA;

    #10 data_b=16'h24FA;

    #10 $finish;
end
endmodule
/* 16‐bit magnitude comparator module*/
module comparator_16b(data_a, data_b, a_gt_b, a_eq_b, a_lt_b);  

input [15:0] data_a;//要進行比較的輸入a,b
input [15:0] data_b;

output a_gt_b; /* a_gt_b = 1 if data_a > data_b */
output a_eq_b; /* a_eq_b = 1 if data_a == data_b */
output a_lt_b; /* a_lt_b = 1 if data_a < data_b */

/*4個comparator_4b所輸出的結果之結合*/
wire[3:0] gt;
wire[3:0] lt;
wire[3:0] eq;

/*實例化4個comparator_4b*/
comparator_4b c1(.data_a(data_a[3:0]),.data_b(data_b[3:0]),.gt(gt[0]),.eq(eq[0]),.lt(lt[0]));//使用"name mapping"
comparator_4b c2(.data_a(data_a[7:4]),.data_b(data_b[7:4]),.gt(gt[1]),.eq(eq[1]),.lt(lt[1]));
comparator_4b c3(.data_a(data_a[11:8]),.data_b(data_b[11:8]),.gt(gt[2]),.eq(eq[2]),.lt(lt[2]));
comparator_4b c4(.data_a(data_a[15:12]),.data_b(data_b[15:12]),.gt(gt[3]),.eq(eq[3]),.lt(lt[3]));

/*實例化一個level 2的comparator_4b來得出最終結果*/
comparator_4b c5(.data_a(gt[3:0]),.data_b(lt[3:0]),.gt(a_gt_b),.eq(a_eq_b),.lt(a_lt_b));

endmodule
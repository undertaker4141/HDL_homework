/* ALU module*/
module ALU(y,cout,a,b,op);

input[15:0] a;//要進行邏輯運算的輸入a,b
input[15:0] b;

input[2:0] op;//用以選擇的op

output[15:0] y;//輸出的結果

output cout;//輸出的cout

wire[15:0] a1,a2,a3,a4;//用以暫存邏輯與算術區所產生的結果
wire[15:0] l1,l2,l3,l4;

wire temp_cout_add_part,temp_cout_sub_part;//用以暫存算術區所產生的cout

arithmetic arit_part(a1,a2,a3,a4,temp_cout_add_part,temp_cout_sub_part,a,b);//實例化arithmetic

logic logic_part(l1,l2,l3,l4,a,b);//實例化logic

MUX mux(y,cout,a1,a2,a3,a4,l1,l2,l3,l4,op[1:0],temp_cout_add_part,temp_cout_sub_part,op[2]);//實例化MUX

endmodule

/* arithmetic module*/
module arithmetic(a1,a2,a3,a4,temp_cout_add_part,temp_cout_sub_part,a,b);

input[15:0] a;//要進行算數運算的輸入a,b
input[15:0] b;

output[15:0] a1,a2,a3,a4;//用以暫存算術區所產生的結果

output temp_cout_add_part,temp_cout_sub_part;//用以暫存算術區所產生的cout結果

/*根據 Function 進行運算將結果存入對應的暫存算術區的輸出變數中*/
assign {temp_cout_add_part,a1} = a + b;
assign {temp_cout_sub_part,a2} = a - b;
assign a3 = a > b ? a : b;
assign a4 = a < b ? a : b;

endmodule

/* logic module*/
module logic(l1,l2,l3,l4,a,b);

input[15:0] a;//要進行邏輯運算的輸入a,b
input[15:0] b;

output[15:0] l1,l2,l3,l4;//用以暫存邏輯區所產生的結果

/*根據 Function 進行運算將結果存入對應的暫存邏輯區的輸出變數中*/
assign l1 = a & b;
assign l2 = a | b;
assign l3 = a ^ b;
assign l4 = ~(a ^ b);

endmodule

/* MUX module*/
module MUX(y,cout,a1,a2,a3,a4,l1,l2,l3,l4,op_MUX_part,tbd_cout_add_part,tbd_cout_sub_part,op_module_part);

input [15:0] a1,a2,a3,a4,l1,l2,l3,l4;//用以存儲算術區及邏輯區所暫存之所有輸出結果，當作輸入

input [1:0] op_MUX_part;//op[1:0]做為一個 4 選 1 的 MUX 的 s0 與 s1

input tbd_cout_add_part,tbd_cout_sub_part;//用以存儲算術區所產生的cout結果，當作輸入

input op_module_part;//op[2]做為一個算術區及邏輯區的選擇器

output [15:0] y;//最後選擇後輸出的結果

output cout;//最後選擇後輸出的結果的cout

wire [15:0] y1,y2,y3,y4;//用以暫存op[2]選擇完算術模型或邏輯模型後的結果

/*用 op[2]分離算術指令區與邏輯指令區並將選擇結果存入暫存變數中*/
assign y1 = (op_module_part) ? l1 : a1;
assign y2 = (op_module_part) ? l2 : a2;
assign y3 = (op_module_part) ? l3 : a3;
assign y4 = (op_module_part) ? l4 : a4;

/*4 選 1 的 MUX 根據 op[1:0] 作為選擇器的結果進行輸出*/
assign y = (op_MUX_part == 2'b00) ? y1 : (op_MUX_part == 2'b01) ? y2 : (op_MUX_part == 2'b10) ? y3 : y4;

/*根據 y 的結果選擇相應的cout輸出*/
assign cout =  (y == a1) ? tbd_cout_add_part : (y == a2) ? tbd_cout_sub_part : 1'b0;

endmodule
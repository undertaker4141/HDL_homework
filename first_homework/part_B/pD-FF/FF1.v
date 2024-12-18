//FF1檔案(positive edge trigger, active high synchronous reset)
module FF1_Sync_Ver(q,d,clk,rst);////模仿講義寫法D-FF
output q;
input d,clk,rst;
reg q;

always @(posedge clk)//positive edge trigger, active high synchronous reset
    if(rst)
        q<=0;
    else
        q<=d;
endmodule
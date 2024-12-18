//FF2檔案(negative edge trigger, active low asynchronous reset)
module FF2_Async_Ver(q,d,clk,rst);//模仿講義寫法D-FF
output q;
input d,clk,rst;
reg q;

always @(negedge clk or negedge rst)//negative edge trigger, active low asynchronous reset
    if(!rst)
        q<=0;
    else
        q<=d;
endmodule
module ram1024x8(clk,addr,data,rw,cs);
input clk;
input [9:0]addr;
input cs, rw;
reg [7:0] ram [0:1023];

inout [7:0] data;   /* external I/O node, bidirectional */
 wire [7:0] dout;    /* internal node, uni‐directional */
 assign data = (!cs)&&(!rw) ? dout : 8'bzzzzzzzz;
 assign dout = ram[addr];

always@(posedge clk)begin
    if(!cs&&rw)
        ram[addr] <= data;
end
endmodule
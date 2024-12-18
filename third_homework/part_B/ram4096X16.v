module ram4096X16(clk, addr, data,rw); 
input clk, rw; 
input [11:0] addr; 
inout [15:0] data; 


wire [7:0] data_11;
wire [7:0] data_22;
wire [7:0] data_33;
wire [7:0] data_44;
wire [7:0] data_55;
wire [7:0] data_66;
wire [7:0] data_77;
wire [7:0] data_88;

reg [7:0] data_1;
reg [7:0] data_2;
reg [7:0] data_3;
reg [7:0] data_4;
reg [7:0] data_5;
reg [7:0] data_6;
reg [7:0] data_7;
reg [7:0] data_8;

assign data_11 = (!rw) ? data_1 : 8'bzzzzzzzz;
assign data_22 = (!rw) ? data_2 : 8'bzzzzzzzz;
assign data_33 = (!rw) ? data_3 : 8'bzzzzzzzz;
assign data_44 = (!rw) ? data_4 : 8'bzzzzzzzz;
assign data_55 = (!rw) ? data_5 : 8'bzzzzzzzz;
assign data_66 = (!rw) ? data_6 : 8'bzzzzzzzz;
assign data_77 = (!rw) ? data_7 : 8'bzzzzzzzz;
assign data_88 = (!rw) ? data_8 : 8'bzzzzzzzz;

reg [3:0]cs = 4'b1111;
reg [15:0] dout;        // 緩存讀取的資料
reg [15:0] ibuf_data;   // 緩存寫入的資料

//assign data = dout;
assign data = (!rw) ? dout : 16'bzzzzzzzzzzzzzzzz;


ram1024x8 r1(clk,addr[9:0],data_11,rw,cs[0]);
ram1024x8 r2(clk,addr[9:0],data_22,rw,cs[0]);
ram1024x8 r3(clk,addr[9:0],data_33,rw,cs[1]);
ram1024x8 r4(clk,addr[9:0],data_44,rw,cs[1]);
ram1024x8 r5(clk,addr[9:0],data_55,rw,cs[2]);
ram1024x8 r6(clk,addr[9:0],data_66,rw,cs[2]);
ram1024x8 r7(clk,addr[9:0],data_77,rw,cs[3]);
ram1024x8 r8(clk,addr[9:0],data_88,rw,cs[3]);

always@(posedge clk)begin
    case(addr[11:10])
    2'b00:begin
        cs = 4'b1110;
        if(rw == 1)begin
        ibuf_data <= data; // 將 data 作為輸入，緩存到 ibuf_data
        data_1 = ibuf_data[7:0];
        data_2 = ibuf_data[15:8];
        end
        else begin
            dout[7:0] <= data_11;
            dout[15:8] <= data_22;
        end
    end

    2'b01:begin
        cs = 4'b1101;
        if(rw == 1)begin
        ibuf_data <= data; // 將 data 作為輸入，緩存到 ibuf_data
        data_3 = ibuf_data[7:0];
        data_4 = ibuf_data[15:8];
        end
        else begin
            dout[7:0] <= data_33;
            dout[15:8] <= data_44;
        end
    end

    2'b10:begin
        cs = 4'b1011;
        if(rw == 1)begin
        ibuf_data <= data; // 將 data 作為輸入，緩存到 ibuf_data
        data_5 = ibuf_data[7:0];
        data_6 = ibuf_data[15:8];
        end
        else begin
            dout[7:0] <= data_55;
            dout[15:8] <= data_66;
        end
    end

    2'b11:begin
        cs = 4'b0111;
        if(rw == 1)begin
        ibuf_data <= data; // 將 data 作為輸入，緩存到 ibuf_data
        data_7 = ibuf_data[7:0];
        data_8 = ibuf_data[15:8];
        end
        else begin
            dout[7:0] <= data_77;
            dout[15:8] <= data_88;
        end
    end

    default:
        cs = 4'b1111;
    endcase
end
endmodule
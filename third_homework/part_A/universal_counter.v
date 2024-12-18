module universal_counter (clear, mode, incr, pause, clk, count);
input clear;  /* if clear = 1, count[3:0] is reset at the positive edge of the clock*/
input mode;  /* hexadecimal cpounting if mode = 1, decimal counting if otherwise */ 
input incr;  /* up counting if incr = 1, down counting if incr = 0 */ 
input pause;  /* counting suspended when pause = 1 */ 
input clk; 
output [3:0] count;  /* counter output */
reg [3:0] count; /* register type variable */

always@(posedge clk)
begin
    if(clear == 1)
        count <= 4'd0;
    else if(pause == 0)begin
        if(mode == 1)begin
            if(incr == 1)
                count <= count + 4'h1;
            else
                count <= count - 4'h1;
        end
        else begin
            if(incr == 1)
                count <= count + 4'd1;
            else
                count <= count - 4'd1;
        end
    end
end
endmodule
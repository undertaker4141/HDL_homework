module debounce(clk,in,out);
input clk;
input in;
output out;

parameter WAIT = 3'd0;
parameter DETECT_H_1 = 3'd1;
parameter DETECT_H_2 = 3'd2;
parameter DETECT_H_3 = 3'd3;
parameter DETECT_L_1 = 3'd4;
parameter DETECT_L_2 = 3'd5;
parameter DETECT_L_3 = 3'd6;

reg [2:0] state , next_state;
reg out = 0;

always@(posedge clk)
begin
        state <= next_state; 
end

always@(state , in)
begin
    case(state)
        WAIT:begin
            if(in)
                next_state = DETECT_H_1;
            else
                next_state = DETECT_L_1;
        end

        DETECT_H_1:begin
            if(in)
                next_state = DETECT_H_2;
            else
                next_state = DETECT_L_1;
        end

        DETECT_H_2:begin
            if(in)
                next_state = DETECT_H_3;
            else
                next_state = DETECT_L_1;
        end

        DETECT_H_3:begin
            if(in)
                next_state = DETECT_H_3;
            else
                next_state = DETECT_L_1;
        end

        DETECT_L_1:begin
            if(in)
                next_state = DETECT_H_1;
            else
                next_state = DETECT_L_2;
        end

        DETECT_L_2:begin
            if(in)
                next_state = DETECT_H_1;
            else
                next_state = DETECT_L_3;
        end

        DETECT_L_3:begin
            if(in)
                next_state = DETECT_H_1;
            else
                next_state = DETECT_L_3;
        end

        default: next_state = WAIT;
    endcase
end

always@(state)
begin
    case(state)
        DETECT_H_3: out = 1'b1;
        DETECT_L_3: out = 1'b0;
        default: ;
    endcase
end
endmodule

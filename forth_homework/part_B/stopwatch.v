module stopwatch(clk,reset,start,stop,minute,second);
input clk;
input reset;
input start;
input stop;
output reg [1:0] minute;
output reg [5:0] second;

reg [1:0] start_state , next_start_state;
reg [1:0] stop_state , next_stop_state;

reg start_out = 0;
reg stop_out = 0;

parameter IDEL_start = 0;
parameter SENT_start = 1;
parameter ALREADY_start = 2;

parameter IDEL_stop = 0;
parameter SENT_stop = 1;
parameter ALREADY_stop = 2;

reg running = 0;

always@(*)
begin
    start_state <= next_start_state;
    stop_state <= next_stop_state;
end

always@(start_state , start)
begin
    case(start_state)
        IDEL_start:
            if(start)
                next_start_state = SENT_start;
            else
                next_start_state = IDEL_start;

        SENT_start:
            next_start_state = ALREADY_start;

        ALREADY_start: 
            if(start)
                next_start_state = ALREADY_start;
            else
                next_start_state = IDEL_start;

        default:
            next_start_state = IDEL_start; 
    endcase
end

always@(stop_state , stop)
begin
    case(stop_state)
        IDEL_stop:
            if(stop)
                next_stop_state = SENT_stop;
            else
                next_stop_state = IDEL_stop;

        SENT_stop:
            next_stop_state = ALREADY_stop;

        ALREADY_stop:
            if(stop)
                next_stop_state = ALREADY_stop;
            else
                next_stop_state = IDEL_stop;

        default:
            next_stop_state = IDEL_stop; 
    endcase
end

always@(start_state)
begin
    case(start_state)
        IDEL_start: start_out = 1'b0;
        SENT_start: start_out = 1'b1;
        ALREADY_start: start_out = 1'b0;
        default: start_out = 1'b0;
    endcase
    if(start_out == 1)
        running = 1;
end

always@(stop_state)
begin
    case(stop_state)
        IDEL_stop: stop_out = 1'b0;
        SENT_stop: stop_out = 1'b1;
        ALREADY_stop: stop_out = 1'b0;
        default: stop_out = 1'b0;
    endcase
    if(stop_out == 1)
        running = 0;
end

always@(posedge clk)
begin

    if(reset)
        begin
            minute = 2'd0;
            second = 6'd0;
        end
    else if(running)
        begin
            if(second == 6'd59) begin
                    second = 6'd0;
                if(minute == 2'd3)
                    minute = 2'd0;
                else
                     minute = minute + 1'b1;
                end
            else
                second = second + 1'b1;
        end
end
endmodule
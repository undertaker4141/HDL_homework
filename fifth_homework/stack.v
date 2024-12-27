module stack(clk, data_in, cmd, data_out, full, empty, error);
    input clk;
    input [7:0] data_in; /* input data for push operations, sampled at posedge clk */ 
    input [1:0] cmd;     /* 00: no operation, 01: clear, 10: push, 00: pop, sampled at the positive 
                            edges of the clock */ 
  
    output [7:0] data_out;  /* retrieved data for pop operations, changes at posedge clk */ 
    output full;  /* flag set when the stack is full, updated at negedge clk */ 
    output empty; /* flag set when the stack is empty, updated at negedge clk */ 
    output error; /* flag set when push is asserted if stack is full or when pop is asserted if stack is  
                     empty, updated at negedge clk */ 

    reg [7:0] data_out;
    reg full;
    reg empty;
    reg error;

    reg  [7:0] RAM [0:7]; /* 8 X 8 memory module to hold stack data, changes at posedge clk */
    reg  [2:0] sp; /* 3‐bit wide stack pointer, updated at negative edges of the clock */  
    wire [7:0] dout;  /* dout is always equal to RAM[sp] */

    // paramater
    parameter NOP = 2'b0;
    parameter CLR = 2'b1;
    parameter PUSH = 2'b10;
    parameter POP = 2'b11;

    integer i;

    // popping 
    reg [2:0] next_sp;
    reg next_full;
    reg next_empty;
    reg next_error;
    reg [1:0] next_cmd;

    // updated at negative edges
    always@(negedge clk)begin
        sp <= next_sp;
        full <= next_full;
        empty <= next_empty;
        error <= next_error;
    end

    always@(posedge clk)begin
        case(cmd)
            NOP : begin
                next_error <= 0;
            end

            CLR : begin
                next_sp <= 3'b0;
                next_empty <= 1;
                next_full <= 0;
                next_error <= 0;
                for(i = 0; i < 8; i = i + 1)begin
                    RAM[i] <= 8'b0;
                end
            end

            PUSH : begin
                if(full)next_error <= 1;
                else if(sp == 3'b111)begin
                    next_sp <= 3'b0;
                    next_full <= 1;
                    RAM[sp] <= data_in;
                    next_error = 0;
                end
                else begin
                    next_sp <= sp + 3'b1;
                    next_empty = 0;
                    RAM[sp] <= data_in;
                    next_error = 0;
                end
            end

            POP : begin
                if(empty)next_error <= 1;
                else if(full)begin
                    next_sp <= 3'b111;
                    next_full <= 0;
                    next_error = 0;
                end
                else if(sp <= 3'b1)begin
                    next_sp <= 3'b0;
                    next_empty <= 1;
                    next_error <= 0;

                end
                else begin
                    next_sp <= sp - 3'b1;
                    next_error = 0;
                end
            end
        endcase
        next_cmd <= cmd;
        data_out <= (next_cmd == POP && !error)? dout : 8'hxx;
    end

    assign dout = RAM[sp];

endmodule
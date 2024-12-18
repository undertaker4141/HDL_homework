// `timescale 1ns/1ps//調整單位時間為 1ns 
// module ram4096X16_tb;
// reg clk, rw; 
// reg [11:0] addr; 
// wire [15:0] data;

// ram4096X16 test(clk, addr, data,rw); 

// // clk part
// initial begin
//     clk = 0;
//     #5;
//     forever begin
//         clk = ~clk;
//         #5;
//     end
// end

// initial begin
//     rw = 1;
//     addr = 12'h0000;
//     data = 16'h0000;
// end

// endmodule

/*--------------------------------------------------------------------------------------------------------*/

`timescale 1ns/1ps

module ram4096X16_tb;
    reg clk;
    reg rw;
    reg [11:0] addr;
    wire [15:0] data;
    reg [15:0] data_reg; // for writing

    assign data = (rw) ? data_reg : 16'bzzzzzzzzzzzzzzzz;

    ram4096X16 rm(
        .clk(clk),
        .rw(rw),
        .addr(addr),
        .data(data)
    );

    // Generate clock
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    integer k; 
    initial begin
        rw = 0;
        addr = 0;
        data_reg = 0;

        // for k = 0 to 7 (first write)
        for (k = 0; k <= 7; k = k + 1) begin
            // (w, 12'h00k, 16'h000k);
            @(negedge clk);
            rw = 1;
            addr = {8'h00, k[3:0]};
            data_reg = {12'h000, k[3:0]};
            @(posedge clk);
            
            // (w, 12'h40k, 16'h040k);
            @(negedge clk);
            addr = {8'h40, k[3:0]};
            data_reg = {12'h040, k[3:0]};
            @(posedge clk);
            
            // (w, 12'h80k, 16'h080k);
            @(negedge clk);
            addr = {8'h80, k[3:0]};
            data_reg = {12'h080, k[3:0]};
            @(posedge clk);
            
            // (w, 12'hc0k, 16'h0c0k);
            @(negedge clk);
            addr = {8'hc0, k[3:0]};
            data_reg = {12'h0c0, k[3:0]};
            @(posedge clk);
        end
        
        // for k = 1 to 4 (first read)
        for (k = 1; k <= 4; k = k + 1) begin
            // (r, 12'hc0k);
            @(negedge clk);
            rw = 0;
            addr = {8'hc0, k[3:0]};
            @(posedge clk);

            // (r, 12'h80k);
            @(negedge clk);
            addr = {8'h80, k[3:0]};
            @(posedge clk);

            // (r, 12'h40k);
            @(negedge clk);
            addr = {8'h40, k[3:0]};
            @(posedge clk);

            // (r, 12'h00k);
            @(negedge clk);
            addr = {8'h00, k[3:0]};
            @(posedge clk);
        end

        // for k = 0 to 7 (second write)
        for (k = 0; k <= 7; k = k + 1) begin
            // (w, 12'h00k, 16'h0k00);
            @(negedge clk);
            rw = 1;
            addr = {8'h00, k[3:0]};
            data_reg = {4'h0, k[3:0], 8'h00};
            @(posedge clk);
            
            // (w, 12'h40k, 16'h0k04);
            @(negedge clk);
            addr = {8'h40, k[3:0]};
            data_reg = {4'h0, k[3:0], 8'h04};
            @(posedge clk);
            
            // (w, 12'h80k, 16'h0k08);
            @(negedge clk);
            addr = {8'h80, k[3:0]};
            data_reg = {4'h0, k[3:0], 8'h08};
            @(posedge clk);
            
            // (w, 12'hc0k, 16'h0k0c);
            @(negedge clk);
            addr = {8'hc0, k[3:0]};
            data_reg = {4'h0, k[3:0], 8'h0c};
            @(posedge clk);
        end

        // for k = 3 to 0 (second read)
        for (k = 3; k >= 0; k = k - 1) begin
            // (r, 12'h00k);
            @(negedge clk);
            rw = 0;
            addr = {8'h00, k[3:0]};
            @(posedge clk);

            // (r, 12'h40k);
            @(negedge clk);
            addr = {8'h40, k[3:0]};
            @(posedge clk);

            // (r, 12'h80k);
            @(negedge clk);
            addr = {8'h80, k[3:0]};
            @(posedge clk);

            // (r, 12'hc0k);
            @(negedge clk);
            addr = {8'hc0, k[3:0]};
            @(posedge clk);
        end

        // Run for a few more cycles to observe final reads
        repeat(5) @(posedge clk);
        
        // End simulation
        $finish;
    end

    always @(posedge clk) begin
        if (!rw) begin
            $display("Reading from address %h: data = %h", addr, data);
        end
        else begin
            $display("Writing to address %h: data = %h", addr, data);
        end
    end
endmodule
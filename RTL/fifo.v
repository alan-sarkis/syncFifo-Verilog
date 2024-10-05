module syncfifo(
    input clk, rst_n,
    input w_en, r_en,
    input [7:0] data_in,
    output reg [7:0] data_out,
    output full, empty    // Flags to prevent reading empty fifo or writing to full fifo 
);

reg [7:0] fifo [7:0]; // FIFO size
reg [2:0] r_ptr, w_ptr; // Data pointers for read and write operations


// Active Low Reset for FIFO
always@(posedge clk)begin
    if(~rst_n)begin
        data_out <= 0;
        r_ptr <= 0;
        w_ptr <= 0;
    end
end

// Writing operation for FIFO
always@(posedge clk)begin
    if(~full && w_en)begin
        fifo[w_ptr] <= data_in;
        w_ptr <= w_ptr + 1;
    end
end

// Reading operation for FIFO
always@(posedge clk)begin
    if(~empty && r_en)begin
        data_out <= fifo[r_ptr];
        r_ptr <= r_ptr + 1;
    end
end


// Conditions for Full and Empty Flags
assign full = (w_ptr == 3'b111);
assign empty = (w_ptr == r_ptr);

endmodule
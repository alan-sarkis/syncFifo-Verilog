module tb();

reg clk = 0, rst_n = 1;
reg w_en = 0, r_en = 0;
reg [7:0] data_in = 0;
wire [7:0] data_out;
wire full, empty;

syncfifo dut(clk,rst_n,w_en,r_en,data_in,data_out,full,empty);

always #5 clk = ~clk;

task write;
begin
    @(posedge clk);
    data_in = $urandom;
    w_en = 1;
    @(posedge clk);
    w_en = 0;
end
endtask

task read;
begin
    @(posedge clk);
    r_en = 1;
    @(posedge clk);
    r_en = 0;
end
endtask

initial begin
    rst_n = 0;
    repeat(5) @(posedge clk);
    rst_n = 1;
    repeat(2) begin
        repeat(5) write;
        repeat(5) read;
    end

    repeat(5) write;
    repeat(6) read;

    repeat(7) write;
    repeat(6) read;
    $stop;
end




endmodule
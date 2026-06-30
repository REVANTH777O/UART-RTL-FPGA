`timescale 1ns / 1ps

module uart_tb;

reg clk;
reg reset;
reg wr_en;
reg [7:0] d_in;

wire tx_serial_out;
wire busy;

wire [7:0] data_out;
wire ready;

//======================================================
// DUT
//======================================================

uart_top DUT (

    .clk(clk),
    .reset(reset),
    .wr_en(wr_en),
    .d_in(d_in),

    .tx_serial_out(tx_serial_out),
    .busy(busy),

    .data_out(data_out),
    .ready(ready)

);

//======================================================
// 100 MHz Clock
//======================================================

initial
begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

//======================================================
// Stimulus
//======================================================

initial
begin

    //--------------------------------------------------
    // Initialize
    //--------------------------------------------------

    reset = 1'b1;
    wr_en = 1'b0;
    d_in  = 8'h00;

    //--------------------------------------------------
    // Reset
    //--------------------------------------------------

    #100;
    reset = 1'b0;

    //--------------------------------------------------
    // Test Vector 1
    //--------------------------------------------------

    #100;
    d_in  = 8'hA5;
    wr_en = 1'b1;

    #10;
    wr_en = 1'b0;

    wait(ready);

    if(data_out == 8'hA5)
        $display("PASS : A5 Received");
    else
        $display("FAIL : Expected A5 Received %h",data_out);

    //--------------------------------------------------
    // Test Vector 2
    //--------------------------------------------------

    #1000;

    d_in = 8'h3C;
    wr_en = 1'b1;

    #10;
    wr_en = 1'b0;

    wait(ready);

    if(data_out == 8'h3C)
        $display("PASS : 3C Received");
    else
        $display("FAIL : Expected 3C Received %h",data_out);

    //--------------------------------------------------
    // Test Vector 3
    //--------------------------------------------------

    #1000;

    d_in = 8'h81;
    wr_en = 1'b1;

    #10;
    wr_en = 1'b0;

    wait(ready);

    if(data_out == 8'h81)
        $display("PASS : 81 Received");
    else
        $display("FAIL : Expected 81 Received %h",data_out);

    //--------------------------------------------------
    // Test Vector 4
    //--------------------------------------------------

    #1000;

    d_in = 8'h55;
    wr_en = 1'b1;

    #10;
    wr_en = 1'b0;

    wait(ready);

    if(data_out == 8'h55)
        $display("PASS : 55 Received");
    else
        $display("FAIL : Expected 55 Received %h",data_out);

    //--------------------------------------------------
    // Finish
    //--------------------------------------------------

    #5000;

    $display("--------------------------------");
    $display("UART LOOPBACK TEST COMPLETED");
    $display("--------------------------------");

    $finish;

end

endmodule
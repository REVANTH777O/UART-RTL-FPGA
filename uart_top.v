`timescale 1ns / 1ps

module uart_top(

    input clk,
    input reset,
    input wr_en,
    input [7:0] d_in,

    output tx_serial_out,
    output busy,

    output [7:0] data_out,
    output ready

);

//-----------------------------------------------------
// Internal Signals
//-----------------------------------------------------

wire tx_enb;
wire rx_enb;

//-----------------------------------------------------
// Baud Rate Generator
//-----------------------------------------------------

baud_rate_generator baud_gen(

    .clk(clk),
    .reset(reset),

    .tx_enb(tx_enb),
    .rx_enb(rx_enb)

);

//-----------------------------------------------------
// UART Transmitter
//-----------------------------------------------------

transmitter uart_tx(

    .clk(clk),
    .reset(reset),

    .wr_en(wr_en),
    .tx_enb(tx_enb),

    .d_in(d_in),

    .tx_serial_out(tx_serial_out),
    .busy(busy)

);

//-----------------------------------------------------
// UART Receiver
//-----------------------------------------------------

receiver uart_rx(

    .clk(clk),
    .reset(reset),

    .rx_enb(rx_enb),

    .rx_in(tx_serial_out),

    .data_out(data_out),
    .ready(ready)

);

endmodule
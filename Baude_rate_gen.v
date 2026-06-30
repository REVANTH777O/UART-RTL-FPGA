`timescale 1ns / 1ps

module baud_rate_generator(

    input clk,
    input reset,

    output reg tx_enb,
    output reg rx_enb

);

reg [13:0] tx_count;
reg [9:0]  rx_count;

always @(posedge clk)
begin

    if(reset)
    begin
        tx_count <= 14'd0;
        rx_count <= 10'd0;

        tx_enb <= 1'b0;
        rx_enb <= 1'b0;
    end
    else
    begin

        //----------------------------
        // UART TX Enable (9600 baud)
        //----------------------------

        if(tx_count == 14'd10416)
        begin
            tx_count <= 14'd0;
            tx_enb <= 1'b1;
        end
        else
        begin
            tx_count <= tx_count + 1'b1;
            tx_enb <= 1'b0;
        end

        //-----------------------------------------
        // UART RX Enable (16x Oversampling)
        //-----------------------------------------

        if(rx_count == 10'd651)
        begin
            rx_count <= 10'd0;
            rx_enb <= 1'b1;
        end
        else
        begin
            rx_count <= rx_count + 1'b1;
            rx_enb <= 1'b0;
        end

    end

end

endmodule
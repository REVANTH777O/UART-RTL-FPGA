`timescale 1ns / 1ps

module transmitter(

    input clk,
    input reset,
    input wr_en,
    input tx_enb,
    input [7:0] d_in,

    output reg tx_serial_out,
    output reg busy

);

//======================================================
// State Encoding
//======================================================

parameter IDLE  = 2'b00;
parameter START = 2'b01;
parameter DATA  = 2'b10;
parameter STOP  = 2'b11;

//======================================================
// Registers
//======================================================

reg [1:0] state;
reg [7:0] data;
reg [2:0] count;

//======================================================
// UART Transmitter FSM
//======================================================

always @(posedge clk)
begin

    if(reset)
    begin
        state         <= IDLE;
        data          <= 8'd0;
        count         <= 3'd0;

        tx_serial_out <= 1'b1;
        busy          <= 1'b0;
    end

    else
    begin

        case(state)

        //==================================================
        // IDLE
        //==================================================

        IDLE :
        begin

            tx_serial_out <= 1'b1;
            busy <= 1'b0;

            if(wr_en)
            begin
                data  <= d_in;
                count <= 3'd0;
                state <= START;
            end

        end

        //==================================================
        // START BIT
        //==================================================

        START :
        begin

            tx_serial_out <= 1'b0;
            busy <= 1'b1;

            if(tx_enb)
            begin
                state <= DATA;
            end

        end

        //==================================================
        // DATA BITS
        //==================================================

        DATA :
        begin

            busy <= 1'b1;

            tx_serial_out <= data[count];

            if(tx_enb)
            
            begin
                        if(count == 7)
                        begin
                            state <= STOP;
                            count <= 0;
                        end
                        else
                        begin
                            count <= count + 1;
                            state <= DATA;
                        end
            end

        end

        //==================================================
        // STOP BIT
        //==================================================

        STOP :
        begin

            tx_serial_out <= 1'b1;
            busy <= 1'b1;

            if(tx_enb)
            begin
                state <= IDLE;
            end

        end

        default :
        begin
            state <= IDLE;
        end

        endcase

    end

end

endmodule
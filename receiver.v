`timescale 1ns / 1ps

module receiver(

    input        clk,
    input        reset,
    input        rx_enb,
    input        rx_in,

    output reg [7:0] data_out,
    output reg       ready

);

//======================================================
// State Encoding
//======================================================

localparam IDLE  = 2'b00;
localparam START = 2'b01;
localparam DATA  = 2'b10;
localparam STOP  = 2'b11;

//======================================================
// Registers
//======================================================

reg [1:0] state;

reg [3:0] sample_cnt;
reg [2:0] bit_cnt;

reg [7:0] shift_reg;

//======================================================
// UART Receiver
//======================================================

always @(posedge clk)
begin

    if(reset)
    begin
        state      <= IDLE;
        sample_cnt <= 4'd0;
        bit_cnt    <= 3'd0;
        shift_reg  <= 8'd0;
        data_out   <= 8'd0;
        ready      <= 1'b0;
    end

    else
    begin

        // ready is a one-clock pulse
        ready <= 1'b0;

        if(rx_enb)
        begin

            case(state)

            //--------------------------------------------------
            // IDLE
            //--------------------------------------------------

            IDLE:
            begin
                sample_cnt <= 0;
                bit_cnt    <= 0;

                if(rx_in == 1'b0)
                    state <= START;
            end

            //--------------------------------------------------
            // START BIT
            //--------------------------------------------------

            START:
            begin

                if(sample_cnt == 4'd8)
                begin
                    // Verify that it is still a valid start bit
                    if(rx_in == 1'b0)
                    begin
                        sample_cnt <= 0;
                        state <= DATA;
                    end
                    else
                    begin
                        state <= IDLE;
                    end
                end
                else
                begin
                    sample_cnt <= sample_cnt + 1'b1;
                end

            end

            //--------------------------------------------------
            // DATA BITS
            //--------------------------------------------------

            DATA:
            begin

                // Sample in middle of bit
                if(sample_cnt == 4'd8)
                begin
                    shift_reg[bit_cnt] <= rx_in;
                end

                // End of one bit
                if(sample_cnt == 4'd15)
                begin

                    sample_cnt <= 0;

                    if(bit_cnt == 3'd7)
                    begin
                        bit_cnt <= 0;
                        state   <= STOP;
                    end
                    else
                    begin
                        bit_cnt <= bit_cnt + 1'b1;
                    end

                end
                else
                begin
                    sample_cnt <= sample_cnt + 1'b1;
                end

            end

            //--------------------------------------------------
            // STOP BIT
            //--------------------------------------------------

            STOP:
            begin

                if(sample_cnt == 4'd8)
                begin

                    if(rx_in == 1'b1)
                    begin
                        data_out <= shift_reg;
                        ready    <= 1'b1;
                    end

                    sample_cnt <= 0;
                    state <= IDLE;

                end
                else
                begin
                    sample_cnt <= sample_cnt + 1'b1;
                end

            end

            //--------------------------------------------------

            default:
            begin
                state <= IDLE;
            end

            endcase

        end

    end

end

endmodule
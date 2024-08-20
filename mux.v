module mux(mux_sel , ser_data , par_bit , TX_OUT);
input [1:0] mux_sel;
input par_bit;
input ser_data;
output reg TX_OUT;

wire start_bit , stop_bit;

assign start_bit = 0;
assign stop_bit = 1;

always @(*) begin
    case(mux_sel)
        2'b00: TX_OUT = start_bit;
        2'b01: TX_OUT = stop_bit;
        2'b10: TX_OUT = ser_data;
        2'b11: TX_OUT = par_bit;
    default: TX_OUT = stop_bit;
    endcase
end

endmodule

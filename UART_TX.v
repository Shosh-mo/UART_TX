module UART_TX (P_DATA , Data_valid , PAR_EN , PAR_TYP , TX_OUT , busy , clk , rst);
input [7:0] P_DATA;
input Data_valid , PAR_EN , PAR_TYP;
input clk , rst;
output TX_OUT , busy;

wire [1:0] mux_sel;
wire ser_done , ser_en;
wire par_bit , ser_data; 

FSM F1 (Data_valid , PAR_EN , ser_done , ser_en , mux_sel , busy , clk , rst);
serializer S1 (P_DATA , ser_done , ser_data , ser_en , clk , rst);
parity_calc P1 (P_DATA , Data_valid , PAR_TYP , par_bit , clk , rst);
mux M1 (mux_sel , ser_data , par_bit , TX_OUT);

endmodule

vlib work
vlog UART_TX.v UART_TX_tb.v
vsim -voptargs=+acc work.UART_TX_tb
#add wave *
add wave /UART_TX_tb/U1/*
add wave /UART_TX_tb/U1/F1/ns
add wave /UART_TX_tb/U1/F1/cs
run -all
#quit -sim
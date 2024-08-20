module UART_TX_tb ();
reg [7:0] P_DATA;
reg Data_valid , PAR_EN , PAR_TYP;
reg clk , rst;
wire TX_OUT , busy;

UART_TX U1 (P_DATA , Data_valid , PAR_EN , PAR_TYP , TX_OUT , busy , clk , rst);

initial begin
    clk = 0;
    forever 
        #1 clk = ~clk;
end

initial begin
    rst = 0;
    P_DATA = 0;
    Data_valid = 0;
    PAR_EN = 0;
    PAR_TYP = 0; 
    repeat (2)
        @(negedge clk);

    rst = 1;
    P_DATA = 8'b11111111; //invalid data
    Data_valid = 0;
    PAR_EN = 0;
    PAR_TYP = 0;    //even parity
    @(negedge clk);     //idle

    P_DATA = 8'b11100111; //valid data
    Data_valid = 1;
    PAR_EN = 0;
    PAR_TYP = 0;    //even parity  
    @(negedge clk);    //idle to start

    Data_valid = 0;
    repeat(8)
        @(posedge clk); //start to transmit

    repeat (5)
        @(posedge clk);

    rst = 1; ///////////////////////////////////////////////////////////////////
    @(posedge clk)

    rst=1;
    P_DATA = 8'b10101010; //invalid data
    Data_valid = 0;
    PAR_EN = 0;
    PAR_TYP = 0;    //even parity
    @(negedge clk);     //idle

    P_DATA = 8'b00011100; //valid data
    Data_valid = 1;
    PAR_EN = 1;        /////////////////////////////////////////////////////////
    PAR_TYP = 0;    //even parity //EXPECTED PARITY BIT TO BE 1 
    @(negedge clk);    //idle to start

    Data_valid = 0;
    repeat(8)
        @(negedge clk); //start to transmit

    repeat (5)
        @(posedge clk);


    P_DATA = 8'b00001111; //invalid data
    Data_valid = 0;
    PAR_EN = 0;
    PAR_TYP = 0;    //even parity
    @(negedge clk);     //idle

    P_DATA = 8'b10101010; //valid data
    Data_valid = 1;
    PAR_EN = 1;        /////////////////////////////////////////////////////////
    PAR_TYP = 1;    //odd parity  
    @(negedge clk);    //idle to start

    Data_valid = 0;
    repeat(8)
        @(negedge clk); //start to transmit

    repeat (5)
        @(posedge clk);

    $stop;
end

endmodule

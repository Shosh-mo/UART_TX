module FSM (Data_valid , PAR_EN , ser_done , ser_en , mux_sel , busy , clk , rst);
    parameter IDLE = 3'b000;
    parameter START = 3'b001;
    parameter TRANSMIT = 3'b010;
    parameter PARITY = 3'b011;
    parameter STOP = 3'b100;

    input clk , rst;
    input PAR_EN , ser_done , Data_valid;
    output ser_en , busy;
    output reg [1:0] mux_sel;

    reg [2:0] cs , ns;
    //state memory
    always @(posedge clk , negedge rst) begin
        if(~rst)
            cs <= IDLE;
        else
            cs <= ns;
    end

    //next state
    always @(*) begin
        case(cs)
            IDLE:
                if(Data_valid)
                    ns = START;
                else
                    ns = cs;

            START:
                ns = TRANSMIT;

            TRANSMIT:
                if(~ser_done)
                    ns = TRANSMIT;
                else if(PAR_EN)
                    ns = PARITY;
                else
                    ns = STOP;

            PARITY:
                ns = STOP;

            STOP:
                ns = IDLE;

            default: ns = IDLE;
        endcase
    end

    //output logic
    always @(*) begin
        case(cs)
            IDLE: 
                mux_sel = 2'b01;
            START: 
                mux_sel = 2'b00;
            TRANSMIT: 
                mux_sel = 2'b10;
            PARITY: 
                mux_sel = 2'b11;
            STOP: 
                mux_sel = 2'b01;
            default: mux_sel = 2'b01;
        endcase
    end

    assign busy = (cs != IDLE);
    assign ser_en = (cs == TRANSMIT || cs == START);

endmodule
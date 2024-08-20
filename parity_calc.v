module parity_calc (P_DATA , Data_valid , PAR_TYP , par_bit , clk , rst);
input [7:0] P_DATA;
input Data_valid , PAR_TYP , clk , rst;
output reg par_bit;

always @(posedge clk , negedge rst) begin
    if(~rst) begin
        par_bit <= 0;
    end
    else begin
        if(Data_valid) begin
            if(PAR_TYP)
                par_bit <= ~( ^P_DATA );
            else
                par_bit <= ^P_DATA;
        end
    end
end

endmodule

module serializer (P_DATA , ser_done , ser_data , ser_en , clk , rst);
input [7:0] P_DATA;
input ser_en , clk , rst;
output reg ser_done , ser_data;
reg [8:0] P;

reg [3:0] counter;

always @(posedge clk , negedge rst) begin
    P <= {P_DATA[0] , P_DATA};
    if(~rst) begin
        counter <= 7;
        ser_data <= 0;
        ser_done <= 0;
    end
    else if(ser_en) begin
        ser_data <= P[counter];
        counter <= counter - 1;

        if(counter == 0) begin
            ser_data <= P[counter];
            ser_done <= 1;
            counter <= 8;       //1 lost clock cycle
        end
        else begin
            ser_done <= 0;
        end
    end
    else begin
        ser_data <= 0;
        ser_done <= 0;
    end
end

endmodule

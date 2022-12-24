module ForwardingUnit (
    input doesntRequirdForwarding, Afterbubble, clk,
    input [3:0] ALURegsrc , ALURegdest, AlUMEMres, MEMWBres,
    output reg [1:0] SrcChange, DestChange
);

    initial begin
        SrcChange = 00; 
        DestChange = 00;
    end

    always @(*) begin

        if (!doesntRequirdForwarding && !Afterbubble) begin

        SrcChange =   (ALURegsrc == AlUMEMres)? 2'b01
                    : (ALURegsrc == MEMWBres)?  2'b10
                    : 2'b00;
        DestChange =  (ALURegdest == AlUMEMres)? 2'b01
                    : (ALURegdest == MEMWBres)?  2'b10
                    : 2'b00;

        end else begin
            SrcChange = 0;
            DestChange = 0;
        end        

    end



endmodule
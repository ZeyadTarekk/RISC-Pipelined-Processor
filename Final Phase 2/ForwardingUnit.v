module ForwardingUnit (
    input doesntRequirdForwarding, bubbleFromEX_MEM, bubbleFromMEM_WB, clk,
    input [3:0] ALURegsrc , ALURegdest, AlUMEMres, MEMWBres,
    output reg [1:0] SrcChange, DestChange
);

    initial begin
        SrcChange = 00; 
        DestChange = 00;
    end

    always @(*) begin

        if (!doesntRequirdForwarding) begin

        SrcChange =   ((ALURegsrc == AlUMEMres) && !bubbleFromEX_MEM)? 2'b01
                    : ((ALURegsrc == MEMWBres) && !bubbleFromMEM_WB)?  2'b10
                    : 2'b00;
        DestChange =  ((ALURegdest == AlUMEMres) && !bubbleFromEX_MEM)? 2'b01
                    : ((ALURegdest == MEMWBres) && !bubbleFromMEM_WB)?  2'b10
                    : 2'b00;

        end else begin
            SrcChange = 0;
            DestChange = 0;
        end        

    end



endmodule
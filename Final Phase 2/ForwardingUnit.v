module ForwardingUnit (
    input [3:0] ALURegsrc , ALURegdest, AlUMEMres, MEMWBres,
    output reg [1:0] SrcChange, DestChange
);

    always @(*) begin    
        SrcChange =   (ALURegsrc == AlUMEMres) ? 2'b01 
                    : (ALURegsrc == MEMWBres) ? 2'b10 
                    : 2'b00;
        DestChange = (ALURegdest == AlUMEMres) ? 2'b01 
                    : (ALURegdest == MEMWBres) ? 2'b10 
                    : 2'b00;
    end

endmodule
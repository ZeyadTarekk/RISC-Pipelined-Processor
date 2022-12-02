module ForwardingUnit (
    input [3:0] ALURegsrc , ALURegdest, AlUMEMres, MEMWBres,
    output reg [1:0] SrcChange, DestChange
);

    always @(*) begin    
        SrcChange = ALURegsrc == AlUMEMres ? 10 : ( ALURegsrc == MEMWBres ? 01 : 00 );
        DestChange = ALURegdest == AlUMEMres ? 10 : ( ALURegdest == MEMWBres ? 01 : 00 );
    end

endmodule
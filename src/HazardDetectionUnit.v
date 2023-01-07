module HazardDetectionUnit (
    input MemRead,
    input [3:0] ALUDest ,  DecodeSrc , DecodeDest,
    output reg MakeMeBubble);

    assign MakeMeBubble = MemRead && (ALUDest == DecodeSrc || ALUDest == DecodeDest);

endmodule

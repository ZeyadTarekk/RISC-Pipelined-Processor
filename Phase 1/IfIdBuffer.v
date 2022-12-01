module IfIdBuffer(
    input clk, flush
    , input [15:0]  instruction, imm
    , input [31:0] pc, nextPC

    , output reg [31:0] oPc, oNextPC
    , output reg [15:0]  oInstruction, oimm
     );

initial begin
    oimm=0;
    oInstruction=0;
    oNextPC=0;
    oPc=0;
end

always @(posedge clk)
begin 
    oimm=imm;
    oInstruction=instruction;
    oNextPC=nextPC;
    oPc=pc;

    if(flush) begin
        oimm=0;
        oInstruction=0;
        oNextPC=0;
        oPc=0; 
    end

end

endmodule
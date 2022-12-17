module IfIdBuffer (
    input clk, flush,
    input [15:0] instruction,
    input [31:0] pc, nextPC,
    output reg [31:0] oPc, oNextPC,
    output reg [15:0] oInstruction
);

  initial begin
    oPc=0;
    oNextPC=0;
    oInstruction=32'b0;
  end

  always @(posedge flush) begin
      oInstruction = 0;
      oNextPC = 0;
      oPc = 0;
  end
  always @(posedge clk) begin
    oInstruction = instruction;
    oNextPC = nextPC;
    oPc = pc;
  end

endmodule

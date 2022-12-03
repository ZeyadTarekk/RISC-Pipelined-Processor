
module wb_tb ();

  reg regWrite, memOrReg, dstOrPrivate, clk;
  reg [3:0] regDstAddress;
  reg [15:0] memData, aluData;
  wire [15:0] outputRes;

  localparam N = 10;

  WriteBack testWriteBack (
      .regWrite(regWrite),
      .memOrReg(memOrReg),
      .dstOrPrivate(dstOrPrivate),
      .clk(clk),
      .regDstAddress(regDstAddress),
      .memData(memData),
      .aluDat(aluData),
      .outputRes(outputRes)
  );
  initial begin

    clk = 1'b0;

    #N memOrReg = 1'b0;
    clk = 1'b1;

    if (outputRes == aluData) begin
      $display("Alu data Passed");
    end else begin
      $display("Alu data Failed");
    end

    clk = 1'b0;

    #N memOrReg = 1'b1;
    clk = 1'b1;

    if (outputRes == memData) begin
      $display("Data Memory Passed");
    end else begin
      $display("Data Memory Failed");
    end

  end

endmodule

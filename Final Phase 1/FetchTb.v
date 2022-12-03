`include "Fetch.v"

module fetch_tb ();

  reg stall, clk, jumpBit, rst, interruptBit;
  reg [31:0] branchIR, initPc;
  wire [31:0] samePc, nextPc;
  wire [15:0] instruction, immediate, finalInstruction;


  Fetch fetch (
      .stall(stall),
      .clk(clk),
      .jumpBit(jumpBit),
      .rst(rst),
      .interruptBit(interruptBit),
      .finalInstruction(finalInstruction),
      .branchIR(branchIR),
      .initPc(initPc),
      .samePc(samePc),
      .nextPc(nextPc),
      .instructionTest(instruction),
      .immediate(immediate)

  );
  initial begin

    clk = 1'b0;
    stall = 1'b0;
    jumpBit = 1'b0;
    rst = 1'b0;
    interruptBit = 1'b0;
    branchIR = 32'b0;
    initPc = 32'h0;

    stall = 1'b0;
    jumpBit = 1'b0;
    rst = 1'b0;
    interruptBit = 1'b0;
    branchIR = 32'b0;

    if (instruction == 16'b0011100000010001) begin
      $display("IR Passed");
    end else begin
      $display("IR Failed");
    end


    if (instruction == 16'b0000000000000100) begin
      $display("IR Passed");
    end else begin
      $display("IR Failed");
    end
    $display("Immediate: ", immediate);


    if (instruction == 16'b0000000000000100) begin
      $display("IR Passed");
    end else begin
      $display("IR Failed");
    end
    $display("Immediate: ", immediate);


  end

  always #10 clk = !clk;


endmodule

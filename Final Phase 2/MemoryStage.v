module MemoryStage (
    input MemRead,
    MemWrite,
    SPOrALUres,
    clk,
    rst,
    input [1:0] SPOpeartion,
    input [15:0] RegSrc, 
    Data_result,
    output reg [15:0] Data
);

  wire [31:0] spvaule;
  wire [31:0] ActualAddress;
  reg [15:0] mem_array[4095:0];

  SP spmManager (
      .SPOpeartion(SPOpeartion),
      .clk(clk),
      .rst(rst),
      .SPValue(spvaule)
  );

  integer i;
  always @(posedge rst) begin
    for (i = 0; i < 4096; i = i + 1) begin
        mem_array[i] = 0;
    end
  end

  assign ActualAddress = SPOrALUres ? {16'b0, Data_result} : spvaule;
  always @(*) begin
    if (MemWrite) begin
      mem_array[ActualAddress] = RegSrc;
    end else if (MemRead) begin
      Data = mem_array[ActualAddress];
    end
  end

endmodule
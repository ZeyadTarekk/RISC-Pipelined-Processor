module MemWbBuffer (
    input RegWrite,
    MemOrReg,
    DestOrPrivate,
    clk,
    input [3:0] regDestAddress,
    input [15:0] dataRes,
    data,
    output reg oRegWrite,
    oMemOrReg,
    oDestOrPrivate,
    output reg [3:0] oRegDestAddress,
    output reg [15:0] oDataRes,
    oData
);

  initial begin
    oRegWrite = 0;
    oMemOrReg = 0;
    oDestOrPrivate = 0;
    oRegDestAddress = 0;
    oDataRes = 0;
    oData = 0;
  end

  always @(posedge clk) begin
    oRegWrite = RegWrite;
    oMemOrReg = MemOrReg;
    oDestOrPrivate = DestOrPrivate;
    oRegDestAddress = regDestAddress;
    oDataRes = dataRes;
    oData = data;
  end

endmodule

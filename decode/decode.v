`include "regfile.v"
`include "control.v"

module decodeStage (clk, reset,instruction,immediate ,SPOperation,RegWrite,MemRead,MemWrite,MemOrReg,UpdateStatus,ImmOrReg,ALUControl,SPOrALUres,DestOrPrivate,BranchFlag,CarryFlag,PCControl,privateRegWrite,fct,interrupt,firstRegValue,immediateValue);

input[15:0] instruction;
input[15:0] immediate;
input clk;
input reset;
output reg [3:0] ALUControl;
output reg [1:0] SPOperation,CarryFlag,fct;
output reg RegWrite,MemRead,MemWrite,MemOrReg,UpdateStatus,ImmOrReg,SPOrALUres,DestOrPrivate,BranchFlag,PCControl,privateRegWrite,interrupt;
output reg[15:0] firstRegValue;
output reg[15:0] immediateValue;


controlUnit control(instruction[15:11],SPOperation,RegWrite,MemRead,MemWrite,MemOrReg,UpdateStatus,ImmOrReg,ALUControl,SPOrALUres,DestOrPrivate,BranchFlag,CarryFlag,PCControl,privateRegWrite,fct,interrupt,reset);

reg write_enable;
reg [4:0] read_addr, write_addr;
reg [15:0] write_data;
wire [15:0] read_data;

regFile testReg(write_enable,read_data,write_data,clk,reset,read_addr,write_addr);

always @ (posedge clk) begin
  if(opCode == 5'b00011) begin
    // NOT Rdst
    read_addr = instruction[10:7];
    firstRegValue = read_data;
  end

end


endmodule
`include "regfile.v"
`include "control.v"


reg write_enable;
reg [4:0] read_addr, write_addr;
reg [15:0] write_data;
wire [15:0] read_data;



controlUnit control(instruction[15:11],SPOperation,RegWrite,MemRead,MemWrite,MemOrReg,UpdateStatus,ImmOrReg,ALUControl,SPOrALUres,DestOrPrivate,BranchFlag,CarryFlag,PCControl,privateRegWrite,fct,interrupt);

regFile registerFile(write_enable,read_data,write_data,clk,reset,read_addr,write_addr);
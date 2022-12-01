`include "control.v"

module control_tb();
reg [4:0] opCode;
wire [3:0] ALUControl;
wire [1:0] SPOperation,CarryFlag,fct;
wire RegWrite,MemRead,MemWrite,MemOrReg,UpdateStatus,ImmOrReg,SPOrALUres,DestOrPrivate,BranchFlag,PCControl,privateRegWrite,interrupt,reset;

localparam N = 10 ;

controlUnit controlObj(opCode,SPOperation,RegWrite,MemRead,MemWrite,MemOrReg,UpdateStatus,ImmOrReg,ALUControl,SPOrALUres,DestOrPrivate,BranchFlag,CarryFlag,PCControl,privateRegWrite,fct,interrupt,reset);

initial begin
  // $monitor("at time = %3d \nopCode = %d\nSPOperation = %d RegWrite = %d, MemRead = %d MemWrite = %d \nMemOrReg = %d write address = %d, data = %d \n\n\n",$time,opCode,SPOperation,RegWrite,MemRead,MemWrite,MemOrReg,write_addr,write_data);

  opCode = 5'b00001;
  #N
  if(SPOperation==2'b00 && 
  RegWrite==1'b0&&
  MemRead==1'b0&&
  MemWrite==1'b0&&
  MemOrReg==1'b0&&
  UpdateStatus==1'b1&&
  ImmOrReg==1'b0&&
  BranchFlag==1'b0&&
  CarryFlag==2'b11&&
  PCControl==1'b0&&
  privateRegWrite==1'b0) begin
  $display("SETC Passed");
  end
  else begin
  $display("SETC Failed");
  end


end

endmodule
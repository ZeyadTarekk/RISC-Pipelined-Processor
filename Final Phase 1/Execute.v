/*
Module name   : ExecuteStage
Author	      : Beshoy Morad
Functionality : Recieve two operands and apply an operations on them then update the status flag
*/
module ExecuteStage (
	input [3:0] ALUControl,
	input [15:0] RegSrc, RegDst, immediate,
	output reg [3:0] newStatus,
	output reg [15:0] ALUResult
);
  always @(*) begin
		newStatus[2] = 1'bx;
		if (ALUControl == 4'b0000) begin  // ADD
			{newStatus[2], ALUResult} = RegSrc + RegDst;
		end else if (ALUControl == 4'b0001) begin  // SUB
			{newStatus[2], ALUResult} = RegDst - RegSrc;
		end else if (ALUControl == 4'b0010) begin  // AND
			ALUResult = RegSrc & RegDst;
		end else if (ALUControl == 4'b0011) begin  // OR
			ALUResult = RegSrc | RegDst;
		end else if (ALUControl == 4'b0100) begin  // SHL
			{newStatus[2], ALUResult} = RegSrc << immediate;
		end else if (ALUControl == 4'b0101) begin  // SHR
			if (immediate > 16 || immediate < 0) begin
				newStatus[2] = 0;
			end else begin
				newStatus[2] = RegSrc[immediate - 1];
			end
			ALUResult = RegSrc >> immediate;
		end else if (ALUControl == 4'b0110) begin  // NOT
			ALUResult = !RegSrc;
		end else if (ALUControl == 4'b0111) begin  // PASS Second
			ALUResult = RegDst;
		end else if (ALUControl == 4'b1000) begin  // INC
			{newStatus[2], ALUResult} = RegSrc + 1;
		end else if (ALUControl == 4'b1001) begin  // DEC
			{newStatus[2], ALUResult} = RegSrc - 1;
		end else if (ALUControl == 4'b1010) begin  // PASS First
			ALUResult = RegSrc;
		end else begin  // ADD
			{newStatus[2], ALUResult} = RegSrc + RegDst;
		end

		// update the status flag
		newStatus[3] = 1'b1;
		newStatus[1] = ALUResult[15];
		newStatus[0] = (ALUResult == 16'd0);
  end

endmodule

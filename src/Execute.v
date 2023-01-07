module ExecuteStage (
	input ImmOrReg,
	input [1:0] selectSrc, selectDst,
	input [3:0] ALUControl,
	input [15:0] RegSrc, RegDst, immediate, RegSrcFromEx, RegDstFromEx, RegSrcFromMem, RegDstFromMem,
	output reg [3:0] newStatus,
	output reg [15:0] ALUResult, ALUfirstOperand
);

	wire [15:0] RegDstOrImm, Operand1, Operand2;

	assign RegDstOrImm = ImmOrReg? RegDst : immediate;

	assign Operand1 =  (selectSrc == 2'b00)? RegSrc
										:(selectSrc == 2'b01)? RegSrcFromEx
										:(selectSrc == 2'b10)? RegSrcFromMem
										: RegSrc;
	assign ALUfirstOperand = Operand1;
	
	assign Operand2 = (!ImmOrReg)?immediate: 
					  ((selectDst == 2'b00)? RegDstOrImm
					:(selectDst == 2'b01)? RegDstFromEx
					:(selectDst == 2'b10)? RegDstFromMem
					: RegDstOrImm);

  always @(*) begin
		if (ALUControl == 4'b0000) begin  // ADD
			{newStatus[2], ALUResult} = Operand1 + Operand2;
		end else if (ALUControl == 4'b0001) begin  // SUB
			{newStatus[2], ALUResult} = Operand2 - Operand1;
		end else if (ALUControl == 4'b0010) begin  // AND
			ALUResult = Operand1 & Operand2;
		end else if (ALUControl == 4'b0011) begin  // OR
			ALUResult = Operand1 | Operand2;
		end else if (ALUControl == 4'b0100) begin  // SHL
			{newStatus[2], ALUResult} = Operand1 << Operand2;
		end else if (ALUControl == 4'b0101) begin  // SHR
			if (Operand2 > 16 || Operand2 < 0) begin
				newStatus[2] = 0;
			end else begin
				newStatus[2] = Operand1[Operand2 - 1];
			end
			ALUResult = Operand1 >> Operand2;
		end else if (ALUControl == 4'b0110) begin  // NOT
			ALUResult = ~Operand1;
		end else if (ALUControl == 4'b0111) begin  // PASS Second
			ALUResult = Operand2;
		end else if (ALUControl == 4'b1000) begin  // INC
			{newStatus[2], ALUResult} = Operand1 + 1;
		end else if (ALUControl == 4'b1001) begin  // DEC
			{newStatus[2], ALUResult} = Operand1 - 1;
		end else if (ALUControl == 4'b1010) begin  // PASS First
			ALUResult = Operand1;
		end else if (ALUControl == 4'b1111) begin  // Do Nothing
			ALUResult = ALUResult;
		end

		// update the status flag
		newStatus[3] = 1'b1;
		newStatus[1] = ALUResult[15];
		newStatus[0] = (ALUResult == 16'd0);
  end

endmodule

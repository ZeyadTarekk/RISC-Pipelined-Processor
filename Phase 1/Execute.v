module ExecuteStage (
	input updateStatus,
	input [3:0]ALUControl,
	input [15:0]RegSrc, RegDst, immediate,
	output reg [15:0]ALUResult,
	input reset
);
	reg [3:0]CCR; // 1 | carry | negative | zero

	initial begin
		CCR = 4'b1000;
	end

	always @(*) begin
		if (reset == 1'b1) begin
			CCR = 4'b1000;
		end else begin
			if (ALUControl == 4'b0000) begin 				  // ADD
				{ CCR[2], ALUResult } = RegSrc + RegDst;
			end
			else if (ALUControl == 4'b0001) begin		  // SUB
				{ CCR[2], ALUResult } = RegSrc - RegDst;
			end
			else if (ALUControl == 4'b0010) begin		  // AND
				ALUResult = RegSrc & RegDst;
			end
			else if (ALUControl == 4'b0011) begin		  // OR
				ALUResult = RegSrc | RegDst;
			end
			else if (ALUControl == 4'b0100) begin		  // SHL
				{ CCR[2], ALUResult } = RegSrc << immediate;
			end
			else if (ALUControl == 4'b0101) begin		  // SHR
				{ ALUResult, CCR[2] } = RegSrc >> immediate;
			end
			else if (ALUControl == 4'b0110) begin		  // NOT
				ALUResult = !RegSrc;
			end
			else if (ALUControl == 4'b0111) begin		  // PASS Second
				ALUResult = RegDst;
			end
			else if (ALUControl == 4'b1000) begin		  // INC
				{ CCR[2], ALUResult } = RegSrc + 1;
			end
			else if (ALUControl == 4'b1001) begin		  // DEC
				{ CCR[2], ALUResult } = RegSrc - 1;
			end
			else if (ALUControl == 4'b1010) begin		  // PASS First
				ALUResult = RegSrc;
			end
			else begin															  // ADD
				{ CCR[2], ALUResult } = RegSrc + RegDst;
			end
		end

		if (updateStatus == 1'b1) begin
			CCR[1] = ALUResult[15];
			CCR[0] = (ALUResult == 16'd0);
		end
	end

endmodule
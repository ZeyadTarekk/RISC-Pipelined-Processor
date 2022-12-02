/*
Module name   : StatusRegister
Author	      : Beshoy Morad
Functionality : Status unit to control the status flags
*/
module StatusRegister (
	input updateStatus,
	input [1:0] carryFlag,
	input [2:0] functionCode,
	input [3:0] newStatus, savedStatus,
	input reset,
	output reg choosedBit,
	output reg [3:0] StatusFlags
);
  reg [3:0] CCR;  // 1 | carry | negative | zero
	
	initial begin
    CCR = 4'b1000;
  end

	always @(*) begin
		if (reset) begin
			CCR = 4'b1000;
		end else begin
			if (updateStatus) begin
				case (carryFlag)
					2'b00 : CCR = newStatus;
					2'b01 : CCR[2] = 0;
					2'b10 : CCR = savedStatus;
					2'b11 : CCR[2] = 1;
					default: CCR = CCR;
				endcase
			end else begin
				CCR = CCR;
			end

			case (functionCode)
				3'b000: choosedBit = CCR[0];
				3'b001: choosedBit = CCR[1];
				3'b010: choosedBit = CCR[2];
				3'b011: choosedBit = CCR[3];
				default: choosedBit = CCR[3];
			endcase

			StatusFlags = CCR;
		end
	end
endmodule
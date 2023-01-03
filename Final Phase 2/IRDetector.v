module IRDetector (
	input [15:0] iR,
	input clk, jumpBit, interruptBit,
	output reg [15:0] instruction, immediate, 
	output reg iamBubble
);
	reg flag;
	reg [15:0] prevReg;

	initial begin
		flag = 0;
		immediate = 0;
		prevReg = 0;
		instruction = 0;
	end


  always @(iR) begin
		if (flag && !jumpBit && !interruptBit) begin
			immediate   = iR;
			instruction = 16'b0000011111111000;
			instruction[6:3] = prevReg[6:3];	// used for forwarding the imm value from the bubble]
			iamBubble = 1;
			flag = 0;
		end else begin
			instruction = iR;
			iamBubble = 0;
			flag = 0;
		end 

    if (instruction[2] == 1'b1) begin
			flag = 1;
			prevReg=instruction;
		end
  end


endmodule
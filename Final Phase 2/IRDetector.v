module IRDetector (
	input [15:0] iR,
	input clk,
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
		if (flag) begin
			immediate   = iR;
			instruction = 16'b0000011111111000;
			instruction[6:3] = prevReg[6:3];	// used for forwarding the imm value from the bubble
			flag = 0;
		end else begin
			instruction = iR;
		end 

    if (instruction[2] == 1'b1) begin
			flag = 1;
			prevReg=instruction;
		end
  end


endmodule
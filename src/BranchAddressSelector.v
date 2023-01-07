module BranchAddressSelector (
	input DecodeDestOrPrivate, WBDestOrPrivate,
	input [15:0] RegDst,
	input [31:0] privateRegResult,
	output reg [31:0] branchAddress
);
always @(*) begin
  branchAddress = (DecodeDestOrPrivate | WBDestOrPrivate)? privateRegResult : {16'b0, RegDst};
end
endmodule
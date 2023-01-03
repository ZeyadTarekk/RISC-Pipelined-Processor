module BWZZ_TB();

localparam N = 10;

reg clk, reset, interrupt;
reg [15:0] inport;
wire [15:0] outport;

BWZZ yarb(clk, reset, interrupt,inport, outport);

initial begin
	clk = 1'b0;
	reset = 1'b1;
	interrupt = 1'b0;
	inport = 16'b0;

	#(N*2);

	reset = 1'b0;


end

always #N clk = !clk;

endmodule